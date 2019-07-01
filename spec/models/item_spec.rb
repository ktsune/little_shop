require 'rails_helper'

RSpec.describe Item do
  describe 'Relationships' do
    it {should belong_to :merchant}
    it {should have_many(:orders).through(:order_items)}
  end

  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :price}
    it {should validate_presence_of :inventory}
    it {should validate_presence_of :image}
    it {should validate_presence_of :active}
  end
end
