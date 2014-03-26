if @total
  json.total @total
end
json.resources(@resources) do |resource|
  json.partial!('api/resources/resource_teaser', resource: resource)
end
