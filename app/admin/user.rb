ActiveAdmin.register User do
  menu priority: 3

  index do
    selectable_column
    id_column
    column :username
    column :email
    column :last_sign_in
    column :admin
    column :blocked
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :username
      row :email
      row :last_sign_in
      row :admin
      row :blocked
      row :created_at
      row :updated_at
    end

    panel 'Resources' do
      table_for user.resources do
        column 'ID' do |resource|
          link_to resource.id, [ :admin, resource ]
        end
        column 'Title' do |resource|
          link_to resource.title, [ :admin, resource ]
        end
        column 'Category' do |resource|
          link_to resource.category.try(:name), [ :admin, resource.category ]
        end
        column 'Date' do |resource|
          resource.created_at
        end
      end
    end

    Admin::Commentable.show_comments(user, self)

    Admin::Voteable.show_votes(resource, self)
  end
end
