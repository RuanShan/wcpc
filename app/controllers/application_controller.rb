class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_shop_activity
  before_action :set_page_view
  wechat_api


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
    wechat_oauth2("snsapi_userinfo") do |openid,other_info|
      user_info = Wechat.api.user(other_info["openid"])
      logger.debug "user_info=#{user_info.inspect}"
      @current_wechat_user = User.find_or_create_by(uid: openid)
      @current_wechat_user.update_info(user_info)
      if user_info["subscribe"].to_i == 0 && params[:action] != "subscribe"
        redirect_to "/subscribe"
      end
    end
  end


end
