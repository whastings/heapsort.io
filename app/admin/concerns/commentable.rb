module Admin
  module Commentable
    def self.show_comments(resource, admin_page)
      admin_page.instance_eval do
        panel 'Comments' do
          table_for resource.comments do
            column 'ID' do |comment|
              link_to comment.id, [ :admin, comment ]
            end
            column 'User' do |comment|
              link_to comment.user, [ :admin, comment.user ]
            end
            column 'Resource' do |comment|
              link_to comment.resource.title, [ :admin, comment.resource ]
            end
            column 'Date' do |comment|
              comment.created_at
            end
            column 'Content' do |comment|
              comment.content
            end
          end
        end
      end
    end
  end
end
