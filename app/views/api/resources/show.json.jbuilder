json.partial!('api/resources/resource_teaser', resource: @resource)
json.(@resource, :description, :category_id)
json.category_tree @resource.category_tree do |category|
  json.(category, :name, :friendly_id)
end
json.comments @comments, partial: 'api/comments/comment', as: :comment
