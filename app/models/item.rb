class Item < ApplicationRecord
    belongs_to :category
    has_many :order_items
    has_many :orders, :through => :order_items

    has_many :items_suppliers
    has_many :suppliers, :through => :tems_suppliers

    has_many :items_shops
    has_many :shops, :through => :items_shops
end