class OrdersController < ApplicationController

  def new
    @items = cart.display_cart
  end

  def create
    username = params[:name]
    address = params[:address], + params[:city], + params[:state], + params[:zip]
    shipping = address.join(", ")
    if shipping.include?("")
      flash[:notice] = "You are missing required shipping address information!"
    end
    order = Order.create!(:username => username, :shipping_address => shipping)
    cart.contents.each do |item_id, quantity|
      item = Item.find(item_id)
      order_item = OrderItem.create!(order: order, item: item, price: item.price, quantity: quantity)
    end
    redirect_to order_path(order)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end
end
