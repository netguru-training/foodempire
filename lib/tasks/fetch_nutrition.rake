namespace :fetch_nutrition do
  desc 'Fetch Nutritions'
  task :run  => :environment  do
    NutritionValueFetcher.call
  end
end
