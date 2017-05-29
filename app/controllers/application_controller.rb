class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_shop_activity
  before_action :set_page_view
  wechat_api

  def after_sign_out_path_for(current_user)
    new_user_session_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private

  def set_shop_activity
    @shop = Shop.first
    @activity = Activity.first
  end

  def set_page_view
    is_xhr = request.xhr?
    if (["visitors","photographs"].include? params[:controller]) && is_xhr.nil?
      @activity.traffic =  @activity.traffic.to_i + 1
      @activity.save
    end
  end

  def set_wechat_user
    #@current_wechat_user = User.find(3)
    #wechat_oauth2("snsapi_userinfo") do |openid,other_info|
    #  user_info = Wechat.api.user(other_info["openid"])
    #  logger.debug "user_info=#{user_info.inspect}"
    #  @current_wechat_user = User.find_or_create_by(uid: openid)
    #  @current_wechat_user.update_info(user_info)
    #  if user_info["subscribe"].to_i == 0 && params[:action] != "subscribe"
    #    redirect_to "/subscribe"
    #  end
    #end
    verify_wechat_subscriber
  end

  def verify_wechat_subscriber
    if Rails.env.development?
      @current_wechat_user = User.find(7)  and return
    end
    if Rails.env.development_hui?
      @current_wechat_user = User.find(2)  and return
    end

    wechat_oauth2("snsapi_base") do |openid,other_info|
      user_info = Wechat.api.user(openid)
      #如果关注了，能够取到用户信息，否则给出关注链接
      logger.debug "user_info=#{user_info.inspect}"
      if user_info
        @current_wechat_user = User.find_or_create_by!(uid: openid)
        @current_wechat_user.update_info(user_info)
        if user_info["subscribe"].to_i == 0 && params[:action] != "subscribe"
          redirect_to "/subscribe"
        end
      else
        redirect_to "/subscribe"
      end
    end
  end

end
