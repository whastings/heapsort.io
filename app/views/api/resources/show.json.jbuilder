json.partial!('api/resources/resource_teaser', resource: @resource)
json.(@resource, :description, :category_id)

