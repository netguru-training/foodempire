namespace :fetch_recipe do
  desc 'Fetch Recipes'
  task :run  => :environment  do
    RecipeFetcher.call
  end
end
