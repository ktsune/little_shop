class OrdersController < ApplicationController

  def new
    @items = cart.display_cart
  end

  def create
    order = Order.new(order_params)
    if order.save
      cart.contents.each do |item_id, quantity|
        item = Item.find(item_id)
        order_item = OrderItem.create!(order: order, item: item, price: item.price, quantity: quantity)
      end
      redirect_to order_path(order)
    else
      flash[:notice] = order.errors.full_messages
      redirect_to new_order_path
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  private

  def order_params
    params.permit(:username, :address, :city, :state, :zipcode)
  end
end
