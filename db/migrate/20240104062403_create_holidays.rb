class CreateHolidays < ActiveRecord::Migration[7.0]
  def change
    create_table :holidays do |t|
      t.string :name
      t.integer :no_of_holidays

      t.timestamps
    end
  end
end
