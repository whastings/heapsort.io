json.(@category, :id, :name)
json.children @children do |child|
  json.(child, :id, :name)
end
json.resources @resources, partial: 'api/resources/resource_teaser', as: :resource
