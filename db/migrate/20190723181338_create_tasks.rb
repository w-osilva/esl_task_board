class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :description, null: false
      t.boolean :done, null: false, default: false
      t.references :story, foreign_key: true

      t.timestamps
    end
  end
end
