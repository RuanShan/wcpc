class VisitorsController < ApplicationController
  layout "wechat"

  def index
    @photographs = @activity.photographs.paginate(:page => params[:page])
  end

  def ranking
    @photographs = @activity.photographs.order("vote_numbers desc").paginate(:page => params[:page])
  end

  def intro
  end

end
