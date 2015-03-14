require_relative '../../app/services/recipe_fetcher'
namespace :fetch_recipe do
  desc ''
  task :run  => :environmen  do
    RecipeFetcher.call
  end
end
