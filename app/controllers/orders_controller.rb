class OrdersController < ApplicationController

  def new
    @items = cart.display_cart
  end

  def create
    binding.pry
    username = params[:name]
    shipping = params[:address], + params[:city], + params[:state], + params[:zip]
    if shipping.include?("")
      flash[:notice] = "You are missing required shipping address information!"
    end
    items = cart.display_cart
    order = Order.order_items.create!(:username => username, :shipping_address => shipping, :items => items)
    redirect_to order_path(order)
  end

  def show
    @order = Order.find(params[:id])
    @items = cart.display_cart
  end
end
