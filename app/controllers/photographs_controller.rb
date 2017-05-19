class PhotographsController < ApplicationController
  layout "wechat"

  def new
    @photograph = @activity.photographs.build(user:User.first)
    5.times { @photograph.photos.build}
  end

  def create
    @photograph = Photograph.create(photograph_params)
    if @photograph.errors.empty?
      flash[:notice] = "作品提交成功"
      redirect_to activity_photograph_path(@activity,@photograph)
    else
      logger.debug "++++++++++++++++++++++++++@photograph.errors=#{@photograph.errors.inspect}"
      (5-@photograph.photos.size).times { @photograph.photos.build}
      render :new
    end

  end

  def show
    @photograph = Photograph.find(params[:id])
  end

  def vote
    @photograph = Photograph.find(params[:id])
    @photograph.vote
    if @photograph.errors.empty?
      flash[:notice] = "投票成功"
    end
  end

  private

  def photograph_params
    params.require(:photograph).permit(:user_id, :activity_id, :name, :intro, :manifesto, photos_attributes: [:photo] )
  end

end
