class CartController < ApplicationController

  def create
    redirect_to '/items'
  end
end
