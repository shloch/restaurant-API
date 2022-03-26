class ItemsSupplier < ApplicationRecord
    belongs_to :supplier
    belongs_to :item
end
