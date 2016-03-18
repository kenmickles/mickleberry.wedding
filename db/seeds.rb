# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Meals
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

meals.each do |data|
  m = Meal.find_or_initialize_by(name: data[:name])
  m.description = data[:description]
  m.save!
end