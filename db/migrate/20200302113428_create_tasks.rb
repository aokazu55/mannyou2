class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.string :deadline, null: false
      t.string :priority, null: false
      t.string :status, null:false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
