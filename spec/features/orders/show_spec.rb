require 'rails_helper'

RSpec.describe "Order show" do
  describe "as a visitor" do

    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    end

    it "shows my created order and all its info" do

      name = 'name'
      address = 'streeterville'
      city = 'city'
      state = 'staterville'
      zip = 12345

      visit "/items/#{@ogre.id}"
      click_button 'Add to Cart'

      visit "/items/#{@giant.id}"
      click_button 'Add to Cart'

      visit '/cart'

      click_link "Checkout"

      within '#shipping' do
        fill_in "Username", with: name
        fill_in "Address", with: address
        fill_in "City", with: city
        fill_in "State", with: state
        fill_in "Zip", with: zip
      end

      click_button "Create Order"

      order = Order.last

      expect(current_path).to eq(order_path(order))
      expect(page).to have_content(name)
      expect(page).to have_content(address)
      expect(page).to have_content(city)
      expect(page).to have_content(state)
      expect(page).to have_content(zip)

      expect(page).to have_content(@giant.name)
      expect(page).to have_content(@ogre.name)
      expect(page).to have_content(@ogre.merchant.name)
      expect(page).to have_content(@giant.merchant.name)
      expect(page).to have_content(@giant.price)
      expect(page).to have_content(@ogre.price)
      expect(page).to have_content("Amount: 1")
      expect(page).to have_content("Amount: 1")
      expect(page).to have_content("Subtotal: 50")
      expect(page).to have_content("Subtotal: 20")
      expect(page).to have_content("Total: 70")

      expect(page).to have_content(order.created_at)
    end

    it "flashes a message if missing information" do

      name = 'name'
      address = 'streeterville'
      city = 'city'
      state = 'staterville'
      zip = 12345

      visit "/items/#{@ogre.id}"
      click_button 'Add to Cart'

      visit "/items/#{@ogre.id}"
      click_button 'Add to Cart'

      visit "/items/#{@giant.id}"
      click_button 'Add to Cart'

      visit '/cart'

      click_link "Checkout"

      within '#shipping' do
        fill_in "Username", with: name
        fill_in "Address", with: address
        fill_in "City", with: city
        fill_in "Zip", with: zip
      end

      click_button "Create Order"
      expect(page).to have_content("You are missing required shipping address information!")
    end
  end
end
