class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :board, null: false
      t.references :user, null: false
      t.string :title
      t.text :content
      t.text :description
      t.date :deadline
      t.timestamps
    end
  end
end