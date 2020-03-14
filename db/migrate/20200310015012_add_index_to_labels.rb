class AddIndexToLabels < ActiveRecord::Migration[5.2]
  def change
    add_index :labels, :user_id
  end
end
