require 'rails_helper'

RSpec.describe Order do
  describe 'relationships' do
    it {should have_many :items}
    it {should have_many(:items).through(:order_items)}
  end

  describe 'Validations' do
    it should {validates_presence_of :username}
    it should {validates_presence_of :address}
    it should {validates_presence_of :city}
    it should {validates_presence_of :state}
    it should {validates_presence_of :zipcode}
  end
end
