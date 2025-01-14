require 'rails_helper'

RSpec.describe 'New Review' do
  describe 'As a Visitor' do
    describe 'When I visit an items show page' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @ogre_review_1 = @ogre.reviews.create!(title: 'Ogres are cool', content: 'I like Ogres', rating: 5)
    end

      it 'I can click a link to a new review form page' do
        visit "/items/#{@ogre.id}"

        click_link 'New Review'

        expect(current_path).to eq("/items/#{@ogre.id}/reviews/new")
      end

      it 'I can create a new review for an item' do
        title = 'Ogres are cool'
        content = "I like Ogres"
        rating = 5

        visit "/items/#{@ogre.id}/reviews/new"

        fill_in 'Title', with: title
        fill_in 'Content', with: content
        fill_in 'Rating', with: rating
        click_button 'Create Review'

        expect(current_path).to eq("/items/#{@ogre.id}")
        expect(page).to have_content(title)
        expect(page).to have_content(content)
        expect(page).to have_content(rating)
      end
    end
  end
end
