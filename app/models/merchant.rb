class Merchant < ApplicationRecord
  has_many :items

  validates_presence_of :name, :address, :city, :state, :zip

  def count_of_items
    self.items.count
  end

  def average_price
    self.items.average(:price)
  end

  def distinct_cities
    binding.pry
    self.order.select(:city).distinct
  end
end
