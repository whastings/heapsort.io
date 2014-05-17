ActiveAdmin.register Comment do
  menu priority: 4
  permit_params :content, :resource_id, :user_id
end
