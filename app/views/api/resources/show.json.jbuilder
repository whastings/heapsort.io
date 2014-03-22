json.partial!('api/resources/resource_teaser', resource: @resource)
json.(@resource, :description, :category_id)
json.comments @comments, partial: 'api/comments/comment', as: :comment
