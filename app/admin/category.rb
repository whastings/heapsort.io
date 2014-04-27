ActiveAdmin.register(Category, label_method: :full_name) do
  decorate_with Admin::CategoryDecorator
  menu priority: 1

  controller do
    defaults finder: :find_by_slug
  end

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :parent
      row :slug
      row :created_at
      row :updated_at
    end

    panel 'Children' do
      table_for category.children do
        column do |child|
          link_to child.full_name, [ :admin, child ]
        end
      end
    end

    panel 'Resources' do
      table_for category.resources do
        column do |resource|
          link_to resource.title, [ :admin, resource ]
        end
      end
    end
  end

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

end
