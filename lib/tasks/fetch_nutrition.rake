namespace :fetch_nutrition do
  desc 'Fetch Nutritions'
  task :run  => :environment  do
    puts 'task started'
    NutritionValueFetcher.call
    puts 'task ended'
  end
end
