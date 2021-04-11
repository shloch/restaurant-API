class RemovePizzaFromCategoriess < ActiveRecord::Migration[6.0]
  def change
    remove_column :categories, :pizza, :string
    remove_column :categories, :drink, :string
    remove_column :categories, :cake, :string
    remove_column :categories, :glace, :string
    add_column :categories, :cat_name, :string
  end
end
