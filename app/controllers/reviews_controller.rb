class ReviewsController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])
    @review = @item.reviews.new(review_params)
    if @review.save
      redirect_to "/items/#{@item.id}"
    else
      flash[:error] = @review.errors.full_messages.join(". ")
      render :new
    end
  end

  private

  def review_params
    params.permit(:title, :content, :rating)
  end
end
