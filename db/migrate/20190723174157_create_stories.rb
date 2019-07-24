class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.string :name, null: false
      t.string :status
      t.text :description
      t.datetime :started_at
      t.datetime :finished_at
      t.datetime :deadline
      t.integer :points
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
