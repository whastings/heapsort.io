class FixSessionUserIndex < ActiveRecord::Migration
  def up
    remove_index :sessions, :user_id
    add_index :sessions, :user_id
  end

  def down
    add_index :sessions, :user_id, unique: true
  end
end
