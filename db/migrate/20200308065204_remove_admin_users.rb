class RemoveAdminUsers < ActiveRecord::Migration[5.2]
  def down
    remove_table :admin_users do |t|

      t.timestamps
    end
  end
end
