json.array! @categories do |category|
  json.(category, :id, :name, :parent_id)
end
