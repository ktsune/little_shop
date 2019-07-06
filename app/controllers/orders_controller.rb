class OrdersController < ApplicationController

  def new
    @items = cart.display_cart
  end

  def create
    username = params[:name]
    shipping = params[:address], + params[:city], + params[:state], + params[:zip]
    if shipping.include?("")
      flash[:notice] = "You are missing required shipping address information!"
    end
    order = Order.create(:username => username, :shipping_address => shipping)
    redirect_to order_path(order)
  end

  def show
    @order = Order.find(params[:id])
    @items = cart.display_cart
  end
end
