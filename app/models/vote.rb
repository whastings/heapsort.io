# == Schema Information
#
# Table name: votes
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  resource_id :integer          not null
#  direction   :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Vote < ActiveRecord::Base
  UP_VOTE = 1
  DOWN_VOTE = 0

  validates :user_id, :resource_id, :direction, presence: true
  validates :user_id, uniqueness: { scope: :resource_id }
  validates :direction, inclusion: { in: [UP_VOTE, DOWN_VOTE] }

  belongs_to :user
  belongs_to :resource

  def self.record_vote(resource_id, user_id, direction)
    attributes = { resource_id: resource_id, user_id: user_id }
    vote = self.find_by(attributes)
    if vote.nil?
      vote = self.new(attributes)
    else
      return if vote.direction == direction
      vote.resource.decrement!(
        direction == UP_VOTE ? :down_votes_count : :up_votes_count
      )
    end
    vote.direction = direction
    vote.save!
    vote.resource.increment!(
      direction == UP_VOTE ? :up_votes_count : :down_votes_count
    )
  end
end
