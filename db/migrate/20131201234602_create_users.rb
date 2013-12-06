class CreateUsers < ActiveRecord::Migration

  def change
    create_table :users do |t|
      t.string :username, limit: 50, null: false
      t.string :email, limit: 100, null: false
      t.string :password_digest, limit: 60
      t.timestamp :last_sign_in
      t.boolean :admin, default: false, null: false
      t.boolean :blocked, default: false, null: false

      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end

end
