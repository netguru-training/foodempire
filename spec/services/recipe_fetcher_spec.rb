require 'rails_helper'
describe RecipeFetcher do
  before do
    stub_request(:get, 'http://www.recipepuppy.com/api/?p=1')
      .to_return(body: { results: [{ title: 'title1', href: 'http://example.com',
        thumbnail: 'http://example.com/img', ingredients: 'sugar, barbecue' }] }
        .to_json)
  end

  describe '#call' do
    it 'creates a feched recipe' do
      RecipeFetcher.call(1, 1)
      expect(Recipe.first.name).to eq 'title1'
    end

    it 'creates a feched ingredients' do
      RecipeFetcher.call(1, 1)
      expect(Ingredient.all.pluck(:name)).to eq %w[sugar barbecue]
    end
  end
end
