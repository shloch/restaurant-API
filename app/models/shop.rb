class Shop < ApplicationRecord
    has_many :items_shops
    has_many :items, :through => :items_shops

    has_many :order_items
    has_many :orders
end
