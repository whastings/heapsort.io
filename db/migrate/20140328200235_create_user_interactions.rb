class CreateUserInteractions < ActiveRecord::Migration
  def change
    create_table :user_interactions do |t|
      t.references :user, index: true
      t.references :interactive, polymorphic: true, index: true
      t.timestamps
    end
  end
end
