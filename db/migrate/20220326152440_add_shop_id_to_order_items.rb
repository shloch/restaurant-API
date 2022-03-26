class AddShopIdToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_column :order_items, :shop_id, :integer
  end
end
