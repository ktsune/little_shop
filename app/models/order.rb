class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items

  validates_presence_of :username, :shipping_address, :quantity, :subtotal, :total
end
