require 'rails_helper'

RSpec.describe 'Cart Show Page' do
  describe 'As a visitor' do
    describe 'I see all items added to my cart' do

      before :each do
        @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
        @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      end

        it "displays the total number of items in the cart" do
          visit "/items/#{@ogre.id}"
          click_button 'Add to Cart'

          visit "/items/#{@giant.id}"
          click_button 'Add to Cart'

          visit '/cart'

          expect(page).to have_content("Cart: 2")
        end

        it 'I can see the details of every item in the cart' do
          visit "/items/#{@ogre.id}"
          click_button 'Add to Cart'

          visit "/items/#{@giant.id}"
          click_button 'Add to Cart'

          visit "/items/#{@ogre.id}"
          click_button 'Add to Cart'

          visit '/cart'

          expect(page).to have_content("Cart: 3")
          expect(page).to have_content("Subtotal: 50")
          expect(page).to have_content("Total: 90")
          expect(page).to have_content("Ogre")
          expect(page).to have_content(@ogre.merchant.name)
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

        it 'I see a link to remove an item' do
          visit "/items/#{@ogre.id}"
          click_button 'Add to Cart'

          visit "/items/#{@giant.id}"
          click_button 'Add to Cart'

          visit '/cart'

          within "#id-#{@giant.id}", match: :first do
            click_button "Remove from Cart"
          end
          
          expect(page).to have_content("Cart: 1")
          expect(page).to have_content("#{@ogre.name}")
          expect(page).to have_content("#{@ogre.price}")
        end

        it 'next to each item in my cart is an incrementer for quantity of item' do
          visit "/items/#{@ogre.id}"
          click_button 'Add to Cart'

          visit '/cart'
          click_button 'Add 1 item'
          visit '/cart'

          expect(current_path).to eq('/cart')
          expect(page).to have_content("Item Count: 2")
        end

       describe "next to each item in my cart is an incrementer for quantity of item" do
         it 'when the quantity hits zero, the item is removed from the cart' do
           visit "/items/#{@ogre.id}"
           click_button 'Add to Cart'
           visit '/cart'

           expect(page).to have_content("Item Count: 1")
            
           click_button 'Remove 1 item'
           visit '/cart'

           expect(current_path).to eq('/cart')
           expect(page).to have_content("Item Count: 0")
         end
       end
      end

      it 'next to each item in my cart is an incrementer for quantity of item' do
        visit "/items/#{@ogre.id}"
        click_button 'Add to Cart'

        visit '/cart'
        click_button 'Add 1 item'
        visit '/cart'

        expect(current_path).to eq('/cart')
        expect(page).to have_content("Item Count: 2")
      end
    end
  end
end
