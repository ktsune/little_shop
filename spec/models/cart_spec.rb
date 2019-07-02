require 'rails_helper'

RSpec.describe Cart do

  describe "#item_count" do
    it "can calculate the total number of items it holds" do
      cart = Cart.new({ 1 => 2, 2 => 3 })

      expect(cart.item_count).to eq(5)
    end
  end

  describe "#add_item" do
    it "can add items to cart" do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      cart = Cart.new(nil)
      cart.add_item(@ogre.id)

      expect(cart.item_count).to eq(1)
    end
  end
end
