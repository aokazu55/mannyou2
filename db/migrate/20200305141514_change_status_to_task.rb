class ChangeStatusToTask < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :status, :string, null:false
  end
end
