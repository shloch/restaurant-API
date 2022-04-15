class ChangeItemFieldNameInOrderItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :order_items, :items_id
    add_reference :order_items, :items, null: false, foreign_key: true
    # t.references :item, null: false, foreign_key: true
  end
end
