namespace :fetch_nutrition do
  desc 'Fetch Nutritions'
  task :run  => :environment  do
    puts 'task started'
    NutritionValueFetcher.call
  end
end
