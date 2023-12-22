class AddColumnsIntoUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :zip_code, :string
    add_column :users, :employee_code, :string
    add_column :users, :dob, :string
  end
end
