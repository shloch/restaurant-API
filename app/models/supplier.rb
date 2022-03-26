class Supplier < ApplicationRecord
    has_many :items_suppliers
    has_many :items, :through => :tems_suppliers
end
