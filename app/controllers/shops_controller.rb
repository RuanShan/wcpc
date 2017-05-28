class ShopsController < ApplicationController

  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    @shop = Shop.find(params[:id])
    @shop.update(shop_params)
    render :edit
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :logo, :intro)
  end

end
