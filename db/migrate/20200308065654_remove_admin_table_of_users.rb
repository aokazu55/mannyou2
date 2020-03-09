class RemoveAdminTableOfUsers < ActiveRecord::Migration[5.2]
  def down
    drop_table :admin_users
  end
end
