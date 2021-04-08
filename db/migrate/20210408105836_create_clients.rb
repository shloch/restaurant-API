class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :sex
      t.string :city
      t.string :name
      t.string :email
      t.string :address
      t.datetime :dateofbirth
      t.string :creditCard

      t.timestamps
    end
  end
end
