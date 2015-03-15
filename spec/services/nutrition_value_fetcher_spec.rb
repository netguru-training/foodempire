require 'rails_helper'
require 'open-uri'
require 'json'
require 'spec_helper'
describe NutritionValueFetcher do
  before do
  stub_request(:get, File.read(File.expand_path('../../fixtures/nutritions_apple.json',__FILE__)))
    .to_return(body: { results: [{ name: 'title1' }] }
              .to_json)
  end
  let!(:apple) { create(:ingredient, name: 'apple',id: 1) }
  let!(:chicken_soup) { create(:ingredient, name: 'chicken soup  ', id: 2) }

  it 'fetch nutritions for apple' do
    response = JSON.load(File.read(File.expand_path('../../fixtures/nutritions_apple.json',__FILE__)))
    expect(response['hits'][0]['fields']['item_name']).to eq 'Apple - 1 cup slices'
  end

  it 'fetch nutritions for chicken' do
    response = JSON.load(File.read(File.expand_path('../../fixtures/nutritions_chicken_soup.json',__FILE__)))
    expect(response['hits'][2]['fields']['item_name']).to eq 'Chicken Noodle Soup'
  end
end
