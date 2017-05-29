class PhotographsController < ApplicationController
  layout "wechat", only: [:new, :create, :vote]
  before_action :set_wechat_user, only: [:new, :create, :vote, :user_edit, :user_update]
  before_action :authenticate_user!, except: [:new, :create, :vote, :user_edit, :user_update]
  before_action :set_photograph, only: [:show, :edit, :update, :user_edit, :user_update, :destroy, :vote]

  def index
    @photographs = @activity.photographs.paginate(:page => params[:page])
  end

  def search
    if params[:name].present?
      @photographs=@activity.photographs.where("name=?",params[:name]).paginate(:page => params[:page])
    else
      @photographs = @activity.photographs.paginate(:page => params[:page])
    end
    render :index
  end

  def new
    #@photograph = @activity.photographs.build(user_id:@current_wechat_user.id)
    @photograph =  @activity.photographs.find_or_initialize_by(user_id:@current_wechat_user.id)

    if @photograph.persisted?
    #  redirect_to "/show/#{@photograph.id}"
    else
      Photograph.upload_limit.times { @photograph.photos.build}
    end
    Rails.logger.debug "@photograph=#{@photograph.errors.inspect}"
  end

  def create
    @photograph = Photograph.create(photograph_params)
    if params["photograph"]["user_attributes"]
      @current_wechat_user.phone=params["photograph"]["user_attributes"]["phone"]
      @current_wechat_user.save
    end
    if @photograph.errors.empty?
      redirect_to "/show/#{@photograph.id}"
    else
      logger.debug "++++++++++++++++++++++++++@photograph.errors=#{@photograph.errors.inspect}"
      (Photograph.upload_limit-@photograph.photos.size).times { @photograph.photos.build}
      render :new
    end

  end

  def show
  end

  def edit
    (Photograph.upload_limit-@photograph.photos.size).times { @photograph.photos.build}
  end

  def update
    @photograph.update(photograph_params)
    if @photograph.errors.empty?
      flash[:notice] = "作品修改成功"
      redirect_to activity_photograph_path(@activity,@photograph)
    else
      logger.debug "++++++++++++++++++++++++++@photograph.errors=#{@photograph.errors.inspect}"
      (Photograph.upload_limit-@photograph.photos.size).times { @photograph.photos.build}
      render :edit
    end
  end

  def user_edit
    (Photograph.upload_limit-@photograph.photos.size).times { @photograph.photos.build}
  end

  def user_update
    @photograph.update(photograph_params)
    if @photograph.errors.empty?
      respond_to do |format|
        format.html { redirect_to "/show/#{@photograph.id}" }
        format.js { render :user_update }
      end
    else
      logger.debug "++++++++++++++++++++++++++@photograph.errors=#{@photograph.errors.inspect}"
      (Photograph.upload_limit-@photograph.photos.size).times { @photograph.photos.build}
      render :user_edit
    end
  end

  def destroy
    @photograph.destroy
    redirect_to activity_photographs_path(@activity)
  end

  def vote
    @vote = @photograph.vote(@current_wechat_user.id)
  end

  private

  def photograph_params
    params.require(:photograph).permit(:user_id, :activity_id, :name, :intro, :manifesto, photos_attributes: [:id,:photo,:_destroy], user_attributes: [:id,:photo] )
  end

  def set_photograph
    @photograph = Photograph.find(params[:id])
  end

end
