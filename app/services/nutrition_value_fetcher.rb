require 'open-uri'
require 'json'

class NutritionValueFetcher
  attr_accessor :ingredient

  def initialize(ingredient = nil)
    @ingredient = ingredient
  end

  def self.call(ingredient = nil)
    new(ingredient).call
  end

  def call
    Ingredient.all.each do |ingredient|
      nutritionix_api = open("https://api.nutritionix.com/v1_1/search/" + ingredient.name + "?results=0%3A10&cal_min=0&cal_max=50000&fields=item_name%2Cbrand_name%2Citem_id%2Cbrand_id%2Cnf_calories%2Cnf_sodium%2Cnf_sugars%2Cnf_protein%2Cnf_total_fat%2Cnf_total_carbohydrate%2Cnf_dietary_fiber&appId=70a7ed7d&appKey=32c78462c63d6b4425e87ec9e01f309a").read
      hash = JSON.parse( nutritionix_api )
      hash['hits'].map do |value|
        NutritionValue.create(
                              serving: value['fields']['item_name'],calories: value['fields']['nf_calories'],
                              carbs: value['fields']['nf_total_carbohydrate'],sodium: value['fields']['nf_sodium'],
                              fiber: value['fields']['nf_dietary_fiber'], protein: value['fields']['nf_protein'],
                              ingredient_id: ingredient.id
                              )
      end
    end
  end
end