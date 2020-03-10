class ChangeColumnNameAndEditToLabels < ActiveRecord::Migration[5.2]
  def change
    change_column :labels, :label_type, :string, null: false
    rename_column :labels, :user, :user_id
  end
end
