class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    @item = Item.find(params[:item_id])
    cart = Cart.new(session[:cart])
    cart.add_item(@item.id)
    session[:cart] = cart.contents
    flash[:message] = "#{@item.name} has been added to your cart!"
    redirect_to '/items'
  end

  def show
    @cart = Cart.new(session[:cart])
    binding.pry
  end
end
