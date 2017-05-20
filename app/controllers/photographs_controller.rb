class PhotographsController < ApplicationController
  layout "wechat", only: ["new", "create"]

  before_action :set_photograph, only: [:show, :edit, :update, :destroy, :vote]

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
    @photograph = @activity.photographs.build(user:User.first)
    5.times { @photograph.photos.build}
  end

  def create
    @photograph = Photograph.create(photograph_params)
    if @photograph.errors.empty?
      flash[:notice] = "作品提交成功"
      redirect_to "/show/#{@photograph.id}"
    else
      logger.debug "++++++++++++++++++++++++++@photograph.errors=#{@photograph.errors.inspect}"
      (5-@photograph.photos.size).times { @photograph.photos.build}
      render :new
    end

  end

  def show
  end

  def edit
    (5-@photograph.photos.size).times { @photograph.photos.build}
  end

  def update
    @photograph.update(photograph_params)
    if @photograph.errors.empty?
      flash[:notice] = "作品修改成功"
      redirect_to activity_photograph_path(@activity,@photograph)
    else
      logger.debug "++++++++++++++++++++++++++@photograph.errors=#{@photograph.errors.inspect}"
      (5-@photograph.photos.size).times { @photograph.photos.build}
      render :edit
    end
  end

  def destroy
    @photograph.destroy
    redirect_to activity_photographs_path(@activity)
  end

  def vote
    @photograph.vote
    if @photograph.errors.empty?
      flash[:notice] = "投票成功"
    end
  end

  private

  def photograph_params
    params.require(:photograph).permit(:user_id, :activity_id, :name, :intro, :manifesto, photos_attributes: [:id,:photo,:_destroy] )
  end

  def set_photograph
    @photograph = Photograph.find(params[:id])
  end

end
