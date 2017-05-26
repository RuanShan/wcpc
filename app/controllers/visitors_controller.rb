class VisitorsController < ApplicationController
  layout "wechat"
  before_action :set_wechat_user, except: [:subscribe]

  def index

  end

  def works
    @photographs = @activity.photographs.order("created_at desc").paginate(:page => params[:page])
  end

  def review
  end

  def subscribe
    render :subscribe, layout: 'subscribe'
  end

  def my_account
    @photograph = @activity.photographs.select{|p|p.user_id==@current_wechat_user.id}.first
    @card = Card.first
  end

  def show
    @photograph = Photograph.find(params[:id])
  end

  def ranking
    @photographs = @activity.photographs.order("vote_numbers desc").paginate(:page => params[:page])
  end

  def intro
  end

  private


end
