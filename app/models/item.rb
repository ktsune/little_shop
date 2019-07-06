class Item < ApplicationRecord
  belongs_to :merchant
  has_many :order_items
  has_many :reviews, dependent: :destroy
  has_many :orders, through: :order_items

  validates_presence_of :name, :description, :price, :inventory, :image, :active
end
