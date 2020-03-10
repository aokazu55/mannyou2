class AddReferencesToLabels < ActiveRecord::Migration[5.2]
  def change
    change_column :labels, :user_id, :integer, references:true
  end
end
