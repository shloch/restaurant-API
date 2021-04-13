class AdSexAndPriceToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_column :order_items, :sex, :string
    add_column :order_items, :price, :integer
  end
end
