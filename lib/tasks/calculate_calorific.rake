namespace :calculate_calorific do
  desc 'Caluclate total calories for recipe'
  task :run  => :environment  do
    puts 'task started'
    CalorificRecipeCalculate.call
    puts 'task ended'
  end
end
