class AddRequesterAndOwnerToHistories < ActiveRecord::Migration[5.2]
  def change
    add_reference :stories, :requester, foreign_key: { to_table: 'users'}
    add_reference :stories, :owner, foreign_key: { to_table: 'users' }
  end
end
