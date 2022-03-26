class AddAgeGrouToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_column :order_items, :age_group, :string
  end
end
