class RemovePasswordFromUsers < ActiveRecord::Migration[5.2]
  def down
    remove_column :users, :password, :string, null:false
  end
end
