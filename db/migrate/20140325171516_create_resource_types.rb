class CreateResourceTypes < ActiveRecord::Migration
  def change
    create_table :resource_types do |t|
      t.string :name, limit: 50

      t.timestamps
    end
  end
end
