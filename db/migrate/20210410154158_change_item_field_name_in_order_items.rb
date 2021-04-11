class ChangeItemFieldNameInOrderItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_items, :Item_id
    add_reference :order_items, :item, null: false, foreign_key: true
    # t.references :item, null: false, foreign_key: true
  end
end
