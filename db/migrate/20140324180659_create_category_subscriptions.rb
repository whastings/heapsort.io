class CreateCategorySubscriptions < ActiveRecord::Migration
  def change
    create_table :category_subscriptions do |t|
      t.integer :subscriber_id, null: false
      t.references :category, index: true, null: false

      t.timestamps
    end
    add_index :category_subscriptions,
              [:subscriber_id, :category_id], unique: true
  end
end
