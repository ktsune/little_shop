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
    self.items.joins(:orders).distinct.pluck(:city)
  end

  def active_orders?
    id = self.items.joins(:orders).pluck(:merchant_id).join('')
    # binding.pry
    if id == self.id.to_s
      true
    else
      false
    end
  end
end
