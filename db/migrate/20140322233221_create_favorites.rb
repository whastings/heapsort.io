class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :resource, index: true, null: false
      t.references :user, index: true, null: false

      t.timestamps
    end
  end
end
