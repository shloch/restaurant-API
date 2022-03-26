class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :pizza
      t.string :drink
      t.string :cake
      t.string :glace

      t.timestamps
    end
  end
end
