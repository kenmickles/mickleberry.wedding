namespace :meals do
  desc "Reload Meal data"
  task :reload => :environment do
    meals = [
      {
        name: "Barolo Beef Short Ribs",
        description: ""
      },
      {
        name: "Chatham Cod",
        description: ""
      },
      {
        name: "Charred Grilled Seitan",
        description: ""
      },
    ]

    Meal.destroy_all
    Meal.create!(meals)
  end
end