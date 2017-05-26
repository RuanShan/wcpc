class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where(uid:nil).all
    @wx_users = User.all - @users
  end

  def show
    @user = User.where(id:params[:id]).first
    unless @user == current_user
      redirect_to new_user_session_path, :alert => "Access denied."
    end
  end

end
