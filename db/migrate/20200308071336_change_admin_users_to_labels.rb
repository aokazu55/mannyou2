class ChangeAdminUsersToLabels < ActiveRecord::Migration[5.2]
  def change
    rename_table :admin_users, :labels
  end
end
