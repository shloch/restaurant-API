class CreateJoinTableShopItem < ActiveRecord::Migration[7.0]
  def change
    create_join_table :items, :shops do |t|
      # t.index [:item_id, :shop_id]
      # t.index [:shop_id, :item_id]
    end
  end
end
