class AddVoteCountsToResources < ActiveRecord::Migration
  def change
    add_column :resources, :up_votes_count, :integer, default: 0, null: false
    add_column :resources, :down_votes_count, :integer, default: 0, null: false
    add_index :resources, :up_votes_count
    add_index :resources, :down_votes_count
  end
end
