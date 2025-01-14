class ItemsController < ApplicationController
  # include ActionView::Helpers::TextHelper

  def index
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @items = @merchant.items
    else
      @items = Item.all
    end
  end

  def show
    @item = Item.find(params[:id])
    
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    item = @merchant.items.new(item_params)
    if item.save
      redirect_to "/merchants/#{@merchant.id}/items"
    else
      flash[:error] = item.errors.full_messages.join(". ")
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      redirect_to "/items/#{@item.id}"
    else
      flash[:error] = @item.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    Item.destroy(params[:id])
    redirect_to '/items'
  end

  private

  def item_params
    params.permit(:name, :description, :price, :image, :inventory)
  end
end
