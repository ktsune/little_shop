require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do

      visit '/merchants'

      within 'nav' do
        click_link 'Items'
      end

      expect(current_path).to eq('/items')

      within 'nav' do
        click_link 'Merchants'
      end

      expect(current_path).to eq('/merchants')
    end

    it "has a cart indicator" do
      megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      berry = megan.items.create!(name: "Marionberry", description: "Mamazing", price: 12, image: "https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcS18PMwVlfce-av4EhInVB1eLwVIP2T6kbk_AfbZZZkpRsBNsFcm4yh9KZBPD408zv8Nqdd7DJ9EDP9i7QTyIYeJrUuUNAvgzfnnvHmKaXih4vZ4wZlGJy-&usqp=CAc", inventory: 2)

      visit '/merchants'
      expect(page).to have_content("Cart")

      visit '/merchants/new'
      expect(page).to have_content("Cart")

      visit "/merchants/#{megan.id}"
      expect(page).to have_content("Cart")

      visit '/items'
      expect(page).to have_content("Cart")

      visit "/merchants/#{megan.id}/items"
      expect(page).to have_content("Cart")

      visit "/items/#{berry.id}"
      expect(page).to have_content("Cart")
    end
  end
end
