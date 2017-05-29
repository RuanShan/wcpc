class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where("uid is not NULL").paginate(:page => params[:page])
  end

  def show
    @user = User.where(id:params[:id]).first
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

end
