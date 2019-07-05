require 'rails_helper'

RSpec.describe 'Cart Show Page' do
  describe 'As a visitor' do
    describe 'I see all items added to my cart' do

      before :each do
        @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
        @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      end

        it 'I can see the details of every item in the cart' do
          visit "/items/#{@ogre.id}"
          click_button 'Add to Cart'

          visit "/items/#{@giant.id}"
          click_button 'Add to Cart'

          visit '/cart'

          expect(page).to have_content(@ogre.name)
          expect(page).to have_content(@ogre.image)
          expect(page).to have_content(@ogre.merchant)
          expect(page).to have_content(@ogre.price)
          expect(page).to have_content(@ogre.desired_quantity)


          expect(page).to have_content(@giant.name)
          expect(page).to have_content(@giant.image)
          expect(page).to have_content(@giant.merchant)
          expect(page).to have_content(@giant.price)
          expect(page).to have_content(@giant.desired_quantity)
        end

        it 'I see a link to checkout' do

          visit "/items/#{@ogre.id}"
          click_button 'Add to Cart'

          visit "/items/#{@giant.id}"
          click_button 'Add to Cart'

          visit '/cart'

          click_link "Checkout"
          expect(current_path).to eq(new_order_path)
        end
      end
    end
  end
