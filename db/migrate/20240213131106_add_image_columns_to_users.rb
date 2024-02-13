class AddImageColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    def up
      add_attachment :users, :image
    end
  
    def down
      remove_attachment :users, :image
    end
  end
end
