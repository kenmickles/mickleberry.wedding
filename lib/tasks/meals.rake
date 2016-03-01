namespace :meals do
  desc "Reload Meal data"
  task :reload => :environment do
    meals = [
      {
        name: "Barolo Beef Short Ribs",
        description: "slow cooked • served boneless • red wine demi glaze • topped with onion straws • scalloped potato au gratin tower • served with spring succotash of haricot vert, edamame, red pepper queen corn"
      },
      {
        name: "Chatham Cod",
        description: "meyer lemon leek fondue Lentil and Rice Pilaf • served with spring succotash of haricot vert, edamame, red pepper queen corn"
      },
      {
        name: "Charred Grilled Seitan",
        description: "roasted cauliflower couscous • brussel sprouts • grilled radicchio • preserved lemon • garlic aioli • served with spring succotash haricot vert, edamame, red pepper queen corn"
      },
    ]

    Meal.destroy_all
    Meal.create!(meals)
  end
end