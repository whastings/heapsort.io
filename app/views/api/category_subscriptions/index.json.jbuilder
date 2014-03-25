json.array! @subscriptions do |subscription|
  json.(subscription, :id, :category_id, :category_name)
end
