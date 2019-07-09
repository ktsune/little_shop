class OrdersController < ApplicationController

  def new
    @items = cart.display_cart
  end

  def create
    # binding.pry
    # if shipping.include?("")
    #   flash[:notice] = "You are missing required shipping address information!"
    # end
    order = Order.create!(order_params)
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

  private

  def order_params
    params.permit(:username, :address, :city, :state, :zipcode)
  end
end
