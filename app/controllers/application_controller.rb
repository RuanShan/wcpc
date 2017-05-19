class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_shop_activity
  before_action :set_page_view

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

end
