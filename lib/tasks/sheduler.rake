desc "This task is called by the Heroku scheduler add-on"
task :fetch_recipies_and_nutrition => :environment do
  Rake::Task['fetch_recipe:run'].invoke
  puts "Fetching recipies finished"
  #Rake::Task['fetch_nutrition:run'].invoke
  #puts "Fetching nutrition finished"
end
