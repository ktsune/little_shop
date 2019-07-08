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

  def add_item
    @item = Item.find(params[:item_id])
    cart = Cart.new(session[:cart])
    @items = cart.add_item(@item.id)
    session[:cart] = cart.contents
    quantity = cart.count_item(@item.id)
    redirect_to '/cart'
  end

  def remove_item
    @item = Item.find(params[:item_id])
    cart = Cart.new(session[:cart])
    @items = cart.remove_item(@item.id)
    session[:cart] = cart.contents
    quantity = cart.count_item(@item.id)
    if quantity == 0
      # redirect_to :action => 'delete' and return
    end
    redirect_to '/cart' and return
  end

  def remove_item
    cart.contents.delete(params[:item_id])

    redirect_to '/cart'
  end

  def destroy
    session.delete(:cart)
    redirect_to '/cart'
  end
end

# private
#
#   def delete_redirect
#     quantity = cart.count_item(@item.id)
#     if quantity == 0
#       redirect_to :action => 'delete'
#     end
#   end
