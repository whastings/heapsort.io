# == Schema Information
#
# Table name: favorites
#
#  id          :integer          not null, primary key
#  resource_id :integer          not null
#  user_id     :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Favorite < ActiveRecord::Base
  belongs_to :resource
  belongs_to :user

  validates :resource, :user, presence: true
  validates :resource_id, uniqueness: { scope: :user_id }
end
