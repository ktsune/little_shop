class OrdersController < ApplicationController

  def new
    @items = cart.display_cart
  end

  def create
  end 
end
