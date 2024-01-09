class ChangeDobColumnTypeIntoUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :dob, 'date USING dob::date'
  end
end
