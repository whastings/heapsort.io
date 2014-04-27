ActiveAdmin.register Resource do
  menu priority: 2

  controller do
    defaults finder: :find_by_slug
  end

  index do
    selectable_column
    id_column
    column :title
    column :url
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :url
      row :description
      row :user
      row :category
      row :resource_type
      row :up_votes_count
      row :down_votes_count
      row :slug
      row :created_at
      row :updated_at
    end

    Admin::Commentable.show_comments(resource, self)

    Admin::Voteable.show_votes(resource, self)
  end
end
