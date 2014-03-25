class AddResourceTypeToResources < ActiveRecord::Migration
  def change
    add_column :resources, :resource_type_id, :integer
    add_index :resources, :resource_type_id
  end
end
