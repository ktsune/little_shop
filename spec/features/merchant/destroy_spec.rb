require 'rails_helper'

RSpec.describe 'Destroy Existing Merchant' do
  describe 'As a visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
    end

    it 'I can click button to destroy merchant from database' do
      visit "/merchants/#{@brian.id}"

      click_button 'Delete'

      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content(@brian.name)
    end

    it "there is no button to delete if merchant's items have been ordered" do
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @order_1 = @ogre.orders.create!(username: "Adam", address: "123 Street", city: "city", state: "State", zipcode: 12345)

      visit "/merchants/#{@megan.id}"
      expect(page).to_not have_button 'Delete'

      visit "/merchants/#{@brian.id}"
      expect(page).to have_button 'Delete'
    end
  end
end

# As a visitor
# If a merchant has items that have been ordered
# I can not delete that merchant
# Either:
# - there is no button visible for me to delete the merchant
# - if I click on the delete button, I see a flash message indicating that the merchant can not be deleted.
