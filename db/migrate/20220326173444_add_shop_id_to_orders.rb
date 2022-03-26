class AddShopIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :shop_id, :integer
  end
end
