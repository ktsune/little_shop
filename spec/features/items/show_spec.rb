require 'rails_helper'

RSpec.describe 'Item Show Page' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @ogre_review_1 = @ogre.reviews.create!(title: 'Ogres are cool', content: 'I like Ogres', rating: 5)
      @ogre_review_2 = @ogre.reviews.create!(title: 'Ogres are cool', content: 'I like Ogres', rating: 5)
      @giant_review_1 = @giant.reviews.create!(title: 'Giants are cool', content: 'I like Giants', rating: 5)
      @giant_review_2 = @giant.reviews.create!(title: 'Giants are cool', content: 'I like Giants', rating: 5)
      @hippo_review_1 = @hippo.reviews.create!(title: 'Hippos are cool', content: 'I like Hippos', rating: 5)
      @hippo_review_2 = @hippo.reviews.create!(title: 'Hippos are cool', content: 'I like Hippos', rating: 5)
    end

    it "I can see the items details" do
      visit "/items/#{@ogre.id}"

      expect(page).to have_content(@ogre.name)
      expect(page).to have_content(@ogre.description)
      expect(page).to have_content("Price: #{number_to_currency(@ogre.price)}")
      expect(page).to have_content("Active")
      expect(page).to have_content("Inventory: #{@ogre.inventory}")
      expect(page).to have_content("Sold by: #{@megan.name}")
      expect(page).to have_link(@megan.name)

      expect(page).to have_content(@ogre_review_1.title)
      expect(page).to have_content(@ogre_review_2.title)
      expect(page).to have_content(@ogre_review_1.content)
      expect(page).to have_content(@ogre_review_2.content)
      expect(page).to have_content(@ogre_review_1.rating)
      expect(page).to have_content(@ogre_review_2.rating)

      expect(page).to have_content(@giant_review_1.title)
      expect(page).to have_content(@giant_review_2.title)
      expect(page).to have_content(@giant_review_1.content)
      expect(page).to have_content(@giant_review_2.content)
      expect(page).to have_content(@giant_review_1.rating)
      expect(page).to have_content(@giant_review_2.rating)

      expect(page).to have_content(@hippo_review_1.title)
      expect(page).to have_content(@hippo_review_2.title)
      expect(page).to have_content(@hippo_review_1.content)
      expect(page).to have_content(@hippo_review_2.content)
      expect(page).to have_content(@hippo_review_1.rating)
      expect(page).to have_content(@hippo_review_2.rating)
    end
  end
end
