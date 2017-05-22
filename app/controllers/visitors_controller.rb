class VisitorsController < ApplicationController
  layout "wechat"
  before_action :set_wechat_user
  def index
  end

  def works
    @photographs = @activity.photographs.paginate(:page => params[:page])
  end

  def review
  end

  def my_account
  end

  def show
    @photograph = Photograph.find(params[:id])
  end

  def ranking
    @photographs = @activity.photographs.order("vote_numbers desc").paginate(:page => params[:page])
  end

  private


end
