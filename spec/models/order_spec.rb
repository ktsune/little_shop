require 'rails_helper'

RSpec.describe Order do
  describe 'relationships' do
    it {should have_many :items}
    it {should have_many(:items).through(:order_items)}
  end

  describe 'Validations' do
    it should {validates_presence_of :user_name}
    it should {validates_presence_of :shipping_address}
  end
end
