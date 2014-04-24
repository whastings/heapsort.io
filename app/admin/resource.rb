ActiveAdmin.register Resource do
  menu priority: 2

  controller do
    defaults finder: :find_by_slug
  end
end
