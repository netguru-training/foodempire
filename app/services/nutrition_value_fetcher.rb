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
      if ingredient.nutrition_value_ids.empty?
        nutritionix_api = open("https://api.nutritionix.com/v1_1/search/" + parse_ingredient_name(ingredient.name) + "?results=0%3A10&cal_min=0&cal_max=50000&fields=item_name%2Cbrand_name%2Citem_id%2Cbrand_id%2Cnf_calories%2Cnf_sodium%2Cnf_sugars%2Cnf_protein%2Cnf_total_fat%2Cnf_total_carbohydrate%2Cnf_dietary_fiber&appId=" + Rails.application.secrets.nutritionix_app_id + "&appKey=" + Rails.application.secrets.nutritionix_app_key).read
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

  private
    def parse_ingredient_name(name)
      name_without_spaces = name.strip
      if name_without_spaces.gsub!(' ','%20').present?
        return name.gsub!(' ','%20')
      else
        return name_without_spaces
      end
    end

end