class CreateCategories < ActiveRecord::Migration

  def change
    create_table :categories do |t|
      t.string :name, limit: 100, null: false
      t.integer :parent_id
    end
    add_index :categories, :parent_id
    add_index :categories, :name

    add_column :bookmarks, :category_id, :integer
  end

end
