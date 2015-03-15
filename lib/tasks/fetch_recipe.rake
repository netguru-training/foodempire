namespace :fetch_recipe do
  desc 'Fetch Recipes'
  task :run, [:page, :limit]  => :environment  do |t, args|
    RecipeFetcher.call(args[:page].to_i, args[:limit].to_i)
  end
end
