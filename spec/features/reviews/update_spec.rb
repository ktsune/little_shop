require 'rails_helper'

RSpec.describe 'Update Review' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @ogre_review_1 = @ogre.reviews.create!(title: 'Ogres are cool', content: 'I like Ogres', rating: 5)
    end

    it 'I can click a link to get to an review edit page' do
      visit "/items/#{@ogre.id}"

      click_link 'Edit Review'

      expect(current_path).to eq("/reviews/#{@ogre.id}/edit")
    end

    it 'I can edit the review information' do
      title = 'Ogres are cool'
      content = "I like Ogres"
      rating = 5

      visit "/reviews/#{@ogre.id}/edit"

      fill_in 'Title', with: title
      fill_in 'Content', with: content
      fill_in 'Rating', with: rating
      click_button 'Update Review'

      expect(current_path).to eq("/items/#{@ogre.id}")
      expect(page).to have_content(title)
      expect(page).to have_content(content)
      expect(page).to have_content(rating)
    end
  end
end
