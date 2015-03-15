every 1.day, at: '11:51 am' do
  rake 'fetch_recipe:run'
  rake 'fetch_nutrition'
end
