class AddMobileToClient < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :mobile, :string
  end
end
