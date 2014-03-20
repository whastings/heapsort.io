json.array!(@resources) do |resource|
  json.partial!('api/resources/resource_teaser', resource: resource)
end
