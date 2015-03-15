namespace :fetch_recipe do
  desc 'Fetch Recipes'
  task :run, [:page, :limit]  => :environment  do |t, args|
    if args[:limit].present?
      RecipeFetcher.call(args[:page].to_i, args[:limit].to_i)
    else
      RecipeFetcher.call(args[:page].to_i, 5)
    end
  end
end
