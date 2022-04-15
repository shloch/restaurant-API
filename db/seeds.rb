# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


#DatabaseCleaner.clean_with(:truncation)

french_cities = ["Paris", "Marseille", "Lyon", "Bordeaux", "Nice"]
spanish_cities = ["madrid", "Barcelone", "Seville"]
cities = french_cities + spanish_cities

NUMBER_OF_CLIENTS = 200

 #there're 2 shops for now
TOTAL_SHOPS = 2
EXTRA_ITEMS_ON_COMMANDS = 3000

# --------------------------------------------------------------------
#            Create shops 
# --------------------------------------------------------------------

shops = []
shops << {name: 'La Peche - France', zone: 'Ile de france'} #FranceShopID = 1
shops<< {name: 'La Peche - Spain', zone: 'Barcelone'} #SpainShopID = 2

shops.each do |s|
  Shop.create!(name:  s[:name], zone: s[:zone])
end


# --------------------------------------------------------------------
#            Create clients
# --------------------------------------------------------------------


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
    5.times { Item.create!(category_id: 1, name: "pizza-" + Faker::Food.dish , price: Faker::Number.between(from: 1, to: 8)) } #pizzaID in Category = 1
  when "drinks"
    5.times { Item.create!(category_id: 2, name: "jus-" + Faker::Food.fruits, price: Faker::Number.between(from: 1, to: 8)) } #drinksID in Category = 2
  when "cake"
    5.times { Item.create!(category_id: 3, name: "cake-" + Faker::Food.fruits, price: Faker::Number.between(from: 1, to: 8)) } #cakeID in Category = 3
  when "glaces"
    5.times { Item.create!(category_id: 4, name: "glace-" + Faker::Food.fruits, price: Faker::Number.between(from: 1, to: 8)) } 
  end
end

# --------------------------------------------------------------------
#            Create Orders 
# --------------------------------------------------------------------
NUMBER_OF_ORDERS = 500
FranceShopID = 1
SpainShopID = 2

NUMBER_OF_ORDERS.times do |n|
  clientID = rand(1...NUMBER_OF_CLIENTS)
  
  is_spanish_client = spanish_cities.include? Client.find(clientID).city #if client from spain
  shopID = is_spanish_client ? SpainShopID : FranceShopID
    Order.create!(client_id: clientID, shop_id:  shopID)
end
 
# --------------------------------------------------------------------
#            Create Orders-items
# --------------------------------------------------------------------
def get_age_and_group(client_obj)
  # --------- age calculation -------------------
  t_now = Time.now
  t_birth = client_obj.dateofbirth
  age = t_now.strftime("%Y").to_i - t_birth.strftime("%Y").to_i
  #----------------determine age group-------------
  if ( age < 26)
    age_group = 'Adolescence'
  elsif (age < 36)
    age_group = 'Youths'
  else
    age_group = 'Adults'
  end
  #----------------------------------------------
  return {age: age, age_group: age_group}
end

item_IDs = (1..Item.count).to_a
(1..Order.count).each do |orderID|
  item = Item.find(rand(1..item_IDs.count))
  # begin
  order = Order.find(orderID)
  client = Client.find(order.client_id)
  # --------- age calculation + age group -------------------
  c = get_age_and_group(client)
  #----------------------------------------------
  OrderItem.create!(shop_id: order.shop_id, order_id: orderID, item_id: item.id, client_id: client.id, sex: client.sex, price: item.price, city: client.city, age: c[:age], age_group: c[:age_group])
  # rescue ActiveRecord::RecordInvalid => invalid
  #   puts invalid.record.errors
  # end
end


(1..EXTRA_ITEMS_ON_COMMANDS).each do |x|
  item = Item.find(rand(1..item_IDs.count))
  orderID = rand(1..NUMBER_OF_CLIENTS)
  order = Order.find(orderID)
  client = Client.find(order.client_id)
  # --------- age calculation + age group -------------------
  c = get_age_and_group(client)
  #----------------------------------------------
  OrderItem.create!(shop_id: order.shop_id, order_id: orderID, item_id: item.id, client_id: client.id, sex: client.sex, price: item.price, city: client.city, age: c[:age], age_group: c[:age_group])
end


# --------------------------------------------------------------------
#            Create items-shops 
# --------------------------------------------------------------------
item_IDs = (1..Item.count).to_a
shop_IDs = (1..Shop.count).to_a


(1..item_IDs.count).each do |itemID|
    (1..rand(1..TOTAL_SHOPS)).each do |shopID|
        ItemsShop.create!(item_id: itemID, shop_id: shopID)
    end
end

# --------------------------------------------------------------------
#            Create suppliers 
# --------------------------------------------------------------------
suppliers = ['La Redoute', 'bioDesign', 'Grand Frais', 'Intermarché', 'Leader Price', 'Monoprix', 'Casino', 'Carrefour', 'Système U', 'EPICIER', 'LIDL', 'Ikea', 'Bricorama']
suppliers.each do |s|
  Supplier.create!(name:  s)
end

# --------------------------------------------------------------------
#            Create items-suppliers 
# --------------------------------------------------------------------
item_IDs = (1..Item.count).to_a
supplier_IDs = (1..Supplier.count).to_a
number_of_suppliers = rand(1..supplier_IDs.count)
(1..item_IDs.count).each do |itemID|
    (1..rand(1..suppliers.count)).each do |supplierID|
        ItemsSupplier.create!(item_id: itemID, supplier_id: supplierID)
    end
  
end

p "seeds created"
