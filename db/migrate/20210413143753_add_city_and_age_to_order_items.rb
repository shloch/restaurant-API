class AddCityAndAgeToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_column :order_items, :city, :string
    add_column :order_items, :age, :integer
  end
end
