class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id, null: false
      t.integer :resource_id, null: false
      t.integer :direction, null: false

      t.timestamps
    end
    add_index :votes, [:resource_id, :user_id], unique: true
    add_index :votes, :resource_id
    add_index :votes, :user_id
  end
end
