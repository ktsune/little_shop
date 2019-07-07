require 'rails_helper'

RSpec.describe 'Delete Item' do
  describe 'As a Visitor' do
    describe 'When I visit an items show page' do
      before :each do
        @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
        @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
        @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      end

      it 'I can click a link to delete that item' do
        visit "/items/#{@giant.id}"

        click_link 'Delete'

        expect(current_path).to eq('/items')

        expect(page).to have_css("#item-#{@ogre.id}")
        expect(page).to have_css("#item-#{@hippo.id}")
        expect(page).to_not have_css("#item-#{@giant.id}")
      end

      it "deletes all reviews associated with the item once deleted" do
        r1 = @giant.reviews.create!(title: "Wow", content: "this item cray", rating: 5)
        r2 = @giant.reviews.create!(title: "Holy", content: "French toast!", rating: 3)

        visit "/items/#{@giant.id}"

        click_link 'Delete'

        expect(page).to_not have_content(r1)
        expect(page).to_not have_content(r2)
      end
    end
  end
end
