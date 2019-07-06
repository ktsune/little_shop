require 'rails_helper'

RSpec.describe 'Delete Cart' do
  describe 'As a visitor' do
    describe 'I am able to delete all items in my cart by clicking an empty cart button' do

      before :each do
        @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
        @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      end

        it 'I can click a link to empty my cart IF there are items in it' do
          visit "/items/#{@ogre.id}"
          click_button 'Add to Cart'

          visit "/items/#{@giant.id}"
          click_button 'Add to Cart'

          visit '/cart'
          click_button 'Empty Cart'

          expect(current_path).to eq('/cart')

          expect(page).to have_content("There are no items in your cart!")
          expect(page).to_not have_css("#cart-#{@ogre.id}")
          expect(page).to_not have_css("#cart-#{@giant.id}")
        end
      end
    end
  end
