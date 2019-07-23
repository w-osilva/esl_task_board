class AddManagerToProjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :manager, foreign_key: { to_table: 'users'}
  end
end
