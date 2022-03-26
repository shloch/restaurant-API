class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  belongs_to :client
  belongs_to :shop
  validates :client_id, :order_id, :item_id, :price, :age, numericality: { only_integer: true }
  validates :sex, :city, presence: true

  scope :most_ordered_5_items, -> { select("*, COUNT(order_id) AS countCommands").group("item_id").order("countCommands DESC").take(5) }

  #female results FIRST, male results LAST
  scope :purchases_by_sex, -> { select("*, COUNT(order_id) AS countOrders").group("sex").order("sex") }

  scope :purchases_by_city, -> { select("*, COUNT(order_id) AS countOrders").group("city").order("city") }

  scope :spending_by_age_group, -> { select("*, COUNT(order_id) AS countOrders").group("age_group").sum("price") }

  scope :order_counts_by_age_group, -> { select("*, COUNT(order_id) AS countOrders").group("age_group") }

  def self.highest_spender
      spendingHash = OrderItem.group('order_id').sum("price") #returns {orderID, totalPrice} has in groups
      highest_price = spendingHash.sort_by {|_order_id, price| price}.last   # returns something like [125, 129] where 125=order_id, 129=highest dollar spent
      order = Order.find(highest_price[0]).client_id
      client = Client.find(order) # highest[0] == 125 from above comment (order_id)
      return {clientObj: client, price: highest_price[1]}
  end

  def self.total_spent
    return OrderItem.sum("price")
  end

  
end
