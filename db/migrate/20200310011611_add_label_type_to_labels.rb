class AddLabelTypeToLabels < ActiveRecord::Migration[5.2]
  def change
    add_column :labels, :label_type, :string, null: true
    add_column :labels, :user, :integer, foreign_key: true
  end
end
