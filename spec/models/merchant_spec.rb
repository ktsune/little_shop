require 'rails_helper'

RSpec.describe Merchant do
  describe 'Relationships' do
    it {should have_many :items}
  end

  describe 'Validations' do
    it should {validates_presence_of :name}
    it should {validates_presence_of :address}
    it should {validates_presence_of :city}
    it should {validates_presence_of :state}
    it should {validates_presence_of :zip}
  end
end
