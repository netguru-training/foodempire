namespace :fetch_recipe do
  desc 'Fetch Recipes'
  task :run  => :environment  do
    RecipeFetcher.call(1, 2)
  end
end
