class AddTimestampsToCategories < ActiveRecord::Migration
  def change
    change_table :categories do |t|
      t.timestamps
    end
  end
end
