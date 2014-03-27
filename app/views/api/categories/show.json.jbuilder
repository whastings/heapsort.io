json.(@category, :id, :name, :parent_id, :resources_count, :friendly_id, :parent_friendly_id)
json.children @children do |child|
  json.(child, :id, :name, :friendly_id)
end
json.resources @resources, partial: 'api/resources/resource_teaser', as: :resource
