# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


DatabaseCleaner.clean_with(:truncation)

# --------------------------------------------------------------------
#            Create clients
# --------------------------------------------------------------------
cities = ["Paris", "Marseille", "Lyon", "Bordeaux", "Nice"]
NUMBER_OF_CLIENTS = 200

NUMBER_OF_CLIENTS.times do |n|
  name  = Faker::Name.name
  email = Faker::Internet.email
  creditCard = Faker::Bank.account_number(digits: 13)
  mobile = Faker::PhoneNumber.cell_phone
  dateofbirth = Faker::Time.between(from: 80.years.ago, to: 15.years.ago)
  sex = Faker::Gender.binary_type
  city = cities.sample
  address = Faker::Address.mail_box
  Client.create!(name:  name,
               email: email,
               creditCard: creditCard,
               mobile: mobile,
               dateofbirth: dateofbirth,
               sex: sex,
               city: city,
               address: address)
  end


  #clients = Client.all


# --------------------------------------------------------------------
#            Create categories
# --------------------------------------------------------------------
 
categories = ['pizza', 'drinks', 'cake', 'glaces']
categories.each do |cat|
  Category.create!(cat_name:  cat)
end


# --------------------------------------------------------------------
#            Create items (or food products)
# --------------------------------------------------------------------

categories.each do |cat|
  case cat
  when "pizza"
    5.times { Item.create!(category_id: 1, name: Faker::Food.dish + " pizza", price: Faker::Number.between(from: 1, to: 8)) } #pizzaID in Category = 1
  when "drinks"
    5.times { Item.create!(category_id: 2, name: "jus-" + Faker::Food.fruits, price: Faker::Number.between(from: 1, to: 8)) } #drinksID in Category = 2
  when "cake"
    5.times { Item.create!(category_id: 3, name: Faker::Food.fruits + " cake", price: Faker::Number.between(from: 1, to: 8)) } #cakeID in Category = 3
  when "glaces"
    5.times { Item.create!(category_id: 3, name: Faker::Food.fruits + " glace", price: Faker::Number.between(from: 1, to: 8)) } 
  end
end

# --------------------------------------------------------------------
#            Create Orders 
# --------------------------------------------------------------------
NUMBER_OF_ORDERS = 1000

NUMBER_OF_ORDERS.times do |n|
  Order.create!(client_id: rand(1...NUMBER_OF_CLIENTS))
end
 
# --------------------------------------------------------------------
#            Create Orders-items
# --------------------------------------------------------------------

item_IDs = (1..Item.count).to_a
(1...Order.count).each do |orderID|
  item = Item.find(rand(1..item_IDs.count))
  # begin
    OrderItem.create!(order_id: orderID, item_id: item.id, client_id: Order.find(orderID).client_id)
  # rescue ActiveRecord::RecordInvalid => invalid
  #   puts invalid.record.errors
  # end
end

p "seeds created"
