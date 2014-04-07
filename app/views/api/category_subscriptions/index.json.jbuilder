json.array! @subscriptions do |subscription|
  json.(subscription, :id, :category_id, :category_name)
  json.category_friendly_id(subscription.category.friendly_id)
end
