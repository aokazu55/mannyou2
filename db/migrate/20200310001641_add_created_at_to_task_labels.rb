class AddCreatedAtToTaskLabels < ActiveRecord::Migration[5.2]
  def change
    add_column :task_labels, :created_at, :datetime, null: false
    add_column :task_labels, :updated_at, :datetime, null: false
  end
end
