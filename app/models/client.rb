class Client < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :order_items, dependent: :destroy
end
