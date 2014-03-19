class RenameBookmarksToResources < ActiveRecord::Migration
  def up
    rename_table :bookmarks, :resources
  end

  def down
    rename_table :resources, :bookmarks
  end
end
