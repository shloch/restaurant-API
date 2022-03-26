class AddMobileToClient < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :mobile, :string
  end
end
