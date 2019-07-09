class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items

  end

  def new
  end

  def create
    merchant = Merchant.new(merchant_params)
    if merchant.save
      redirect_to '/merchants'
    else
      flash[:error] = merchant.errors.full_messages.join(". ")
      render :new
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if !@merchant.update(new_params)
      flash[:error] = @merchant.errors.full_messages.join(". ")
    else
      @merchant.update(new_params)
    end
    redirect_to "/merchants/#{@merchant.id}"
  end

  def destroy
    Merchant.destroy(params[:id])
    redirect_to '/merchants'
  end

  private

  def merchant_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def new_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
