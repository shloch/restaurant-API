class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :orders, null: false, foreign_key: true
      t.references :items, null: false, foreign_key: true

      t.timestamps
    end
  end
end
