class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_card, only: [:edit, :update, :destroy]

  def index
    @cards = @shop.cards.order("created_at desc").paginate(:page => params[:page])
  end

  def new
    @card = @shop.cards.build
  end

  def create
    @card = @shop.cards.create(card_params)
    if @card.errors.empty?
      flash[:notice] = "优惠券添加成功"
      redirect_to cards_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @card.update(card_params)
    if @card.errors.empty?
      flash[:notice] = "优惠券修改成功"
      redirect_to cards_path
    else
      render :edit
    end
  end

  def destroy
    if @card.assigned?
      flash[:notice] = "优惠券已经使用，无法删除"
    else
      @card.destroy
    end
    redirect_to cards_path
  end

  private

  def card_params
    params.require(:card).permit(:name, :origin, :url, :start_date, :end_date)
  end

  def set_card
    @card = Card.find(params[:id])
  end

end
