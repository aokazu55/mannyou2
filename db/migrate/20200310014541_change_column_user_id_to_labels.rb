class ChangeColumnUserIdToLabels < ActiveRecord::Migration[5.2]
  def change
    change_column :labels, :user_id, :bigint
  end
end
