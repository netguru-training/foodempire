require 'rails_helper'
require 'open-uri'
require 'json'
require 'spec_helper'
describe NutritionValueFetcher do
  let!(:apple) { create(:ingredient, name: 'apple') }
  let!(:chicken_soup) { create(:ingredient, name: 'chicken soup  ') }

  it 'fetch nutritions for apple' do
    response = JSON.load(File.read(File.expand_path('../../fixtures/nutritions_apple.json',__FILE__)))
    expect(response['hits'][0]['fields']['item_name']).to eq 'Apple - 1 cup slices'
  end

  it 'fetch nutritions for chicken' do
    response = JSON.load(File.read(File.expand_path('../../fixtures/nutritions_chicken_soup.json',__FILE__)))
    expect(response['hits'][2]['fields']['item_name']).to eq 'Chicken Noodle Soup'
  end
end


