require 'rails_helper'

RSpec.describe "Item Link Name" do
  describe "anywhere a visitor clicks on an item's name" do
    describe "except the item's show page" do

      before :each do
        @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
        @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
        @order = Order.create!(username: "Rihanna", address: "Work Werq Werk", city: "Nassau", state: "Florida", zipcode: 98097)
        @order.order_items.create!(quantity: 1, item: @ogre, price: @ogre.price)
      end

      it "takes me to the item's show page" do
        visit "/items/#{@ogre.id}"
        click_button 'Add to Cart'

        visit '/cart'
        expect(page).to have_link("#{@ogre.name}")
        click_link("#{@ogre.name}")
        expect(current_path).to eq("/items/#{@ogre.id}")

        visit "/items"
        expect(page).to have_link("#{@ogre.name}")
        click_link("#{@ogre.name}")
        expect(current_path).to eq("/items/#{@ogre.id}")

        visit new_order_path
        expect(page).to have_link("#{@ogre.name}")
        click_link("#{@ogre.name}")
        expect(current_path).to eq("/items/#{@ogre.id}")
        # binding.pry
        visit order_path(@order)
        expect(page).to have_link("#{@ogre.name}")
        click_link("#{@ogre.name}")
        expect(current_path).to eq("/items/#{@ogre.id}")
      end
    end
  end
end
