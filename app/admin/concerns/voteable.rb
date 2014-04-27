module Admin
  module Voteable
    def self.show_votes(resource, admin_page)
      admin_page.instance_eval do
        panel 'Votes' do
          table_for resource.votes do
            column 'ID' do |vote|
              link_to vote.id, [ :admin, vote ]
            end
            column 'User' do |vote|
              link_to vote.user, [ :admin, vote.user ]
            end
            column 'Resource' do |vote|
              link_to vote.resource.title, [ :admin, vote.resource ]
            end
            column 'Date' do |vote|
              vote.created_at
            end
          end
        end
      end
    end
  end
end
