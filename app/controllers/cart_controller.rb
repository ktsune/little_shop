class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    @item = Item.find(params[:item_id])
    cart = Cart.new(session[:cart])
    @items = cart.add_item(@item.id)
    session[:cart] = cart.contents
    flash[:message] = "#{@item.name} has been added to your cart!"
    quantity = cart.count_item(@item.id)
    flash[:notice] = "You now have #{pluralize(quantity, "copy")} of #{@item.name} in your cart."
    redirect_to '/items'
  end

  def show
    cart = Cart.new(session[:cart])
    @items = cart.display_cart
  end

  def delete
    cart.contents.delete(params[:item_id])
    redirect_to '/cart'
  end

  def destroy
    session.delete(:cart)
    redirect_to '/cart'
  end
end
