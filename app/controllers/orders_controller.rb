class OrdersController < ApplicationController

  def new
    binding.pry
    @items = cart.display_cart
  end
end
