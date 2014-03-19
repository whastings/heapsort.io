json.(@category, :id, :name)
json.chidren @category.children do |child|
  json.(child, :id, :name)
end
json.resources @resources, partial: 'api/resources/resource_teaser', as: :resource
