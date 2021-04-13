class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  belongs_to :client
  validates :client_id, :order_id, :item_id, :price, :age, numericality: { only_integer: true }
  validates :sex, :city, presence: true

  scope :most_ordered_5_items, -> { select("*, COUNT(order_id) AS countCommands").group("item_id").order("countCommands DESC").take(5) }

  #female results FIRST, male results LAST
  scope :purchases_by_sex, -> { select("*, COUNT(order_id) AS countOrders").group("sex").order("sex") }

  scope :purchases_by_city, -> { select("*, COUNT(order_id) AS countOrders").group("city").order("city") }
end
