class CouponsController < ApplicationController
  before_action :set_coupon, only: [:destroy]

  def index
    @coupons = @activity.coupons.order("created_at desc").paginate(:page => params[:page])
  end

  def search
    if params[:serial_number].present?
      @coupons = @activity.coupons.where("serial_number=?",params[:serial_number]).order("created_at desc").paginate(:page => params[:page])
    else
      @coupons = @activity.coupons.order("created_at desc").paginate(:page => params[:page])
    end
    render :index
  end

  def create
    @coupon = Coupon.create(coupon_params)
    redirect_to activity_coupons_path(@activity)
  end

  def destroy
    @coupon.destroy
    redirect_to activity_coupons_path(@activity)
  end

  private

  def coupon_params
    params.require(:coupon).permit(:serial_number, :activity_id)
  end

  def set_coupon
    @coupon = Coupon.find(params[:id])
  end

end
