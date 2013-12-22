class AddOrderingIndexes < ActiveRecord::Migration

  def change
    add_index :users, :created_at
    add_index :bookmarks, :created_at
  end

end
