class Item < ApplicationRecord
  belongs_to :merchant
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :reviews, dependent: :destroy

  validates_presence_of :name, :description, :price, :inventory, :image, :active

  def top_3_reviews
    reviews.select("reviews.*").order(rating: :desc).limit(3)
  end

  def bottom_3_reviews
    reviews.select("reviews.*").order(:rating).limit(3)
  end

  def average_review
    reviews.average(:rating).to_i
  end

  def ordered
    id = orders.pluck(:item_id).join('')
    if id == self.id.to_s
      true
    else
      false
    end 
  end
end
