class Order < ApplicationRecord
  belongs_to :client
  has_many :items, through: :order_items
end
