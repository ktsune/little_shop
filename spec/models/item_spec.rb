require 'rails_helper'

RSpec.describe Item, :type => :model do
  describe 'Relationships' do
    it {should belong_to :merchant}
    it {should have_many :reviews}
    it {should have_many(:orders).through(:order_items)}
  end

  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :price}
    it {should validate_presence_of :inventory}
    it {should validate_presence_of :image}
    it {should validate_presence_of :active}
  end

  describe 'top_3_reviews' do
    it "should list the top 3 reviews" do
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo_review_1 = @hippo.reviews.create!(title: 'Hippos are cheap', content: 'I like Hippos', rating: 4)
      @hippo_review_2 = @hippo.reviews.create!(title: 'Hippos are cool', content: 'I like Hippos', rating: 3)
      @hippo_review_3 = @hippo.reviews.create!(title: 'Do they even swim..?', content: 'I like Hippos', rating: 1)
      @hippo_review_4 = @hippo.reviews.create!(title: 'Yeah, with grace!', content: 'I like Hippos', rating: 5)

      expect(@hippo.top_3_reviews).to eq([@hippo_review_4, @hippo_review_1, @hippo_review_2])
    end
  end

  describe 'bottom_3_reviews' do
    it "should list the bottom 3 reviews" do
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo_review_1 = @hippo.reviews.create!(title: 'Hippos are cheap', content: 'I like Hippos', rating: 1)
      @hippo_review_2 = @hippo.reviews.create!(title: 'Hippos are cool', content: 'I like Hippos', rating: 3)
      @hippo_review_3 = @hippo.reviews.create!(title: 'Do they even swim..?', content: 'I like Hippos', rating: 1)
      @hippo_review_4 = @hippo.reviews.create!(title: 'Yeah, with grace!', content: 'I like Hippos', rating: 4)

      expect(@hippo.bottom_3_reviews).to eq([@hippo_review_1, @hippo_review_3, @hippo_review_2])
    end
  end

  describe "average_review" do
    it "should list the average review rating" do
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo_review_1 = @hippo.reviews.create!(title: 'Hippos are cheap', content: 'I like Hippos', rating: 5)
      @hippo_review_2 = @hippo.reviews.create!(title: 'Hippos are cool', content: 'I like Hippos', rating: 2)
      @hippo_review_3 = @hippo.reviews.create!(title: 'Do they even swim..?', content: 'I like Hippos', rating: 1)
      @hippo_review_4 = @hippo.reviews.create!(title: 'Yeah, with grace!', content: 'I like Hippos', rating: 4)

      expect(@hippo.average_review).to eq(3)
    end
  end
end
