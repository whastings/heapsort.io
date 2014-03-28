# == Schema Information
#
# Table name: user_interactions
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  interactive_id   :integer
#  interactive_type :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class UserInteraction < ActiveRecord::Base
  belongs_to :interactive, polymorphic: true
  belongs_to :user

  def record(object, user)
    object.interactions.create!(user_id: user.id)
  end
end
