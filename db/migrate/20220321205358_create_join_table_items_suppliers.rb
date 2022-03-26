class CreateJoinTableItemsSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_join_table :items, :suppliers do |t|
      # t.index [:item_id, :supplier_id]
      # t.index [:supplier_id, :item_id]
    end
  end
end
