class CreateBookmarks < ActiveRecord::Migration

  def change
    create_table :bookmarks do |t|
      t.string :title, limit: 150, null: false
      t.string :domain, limit: 75, null: false
      t.string :path, null: false, default: '/'
      t.string :query_string
      t.integer :port, null: false, default: 80
      t.string :protocol, limit: 10, null: false, default: 'http'
      t.text :description
      t.integer :user_id, null: false

      t.timestamps
    end
    add_index :bookmarks, [:domain, :path, :query_string], unique: true
    add_index :bookmarks, :user_id
  end

end
