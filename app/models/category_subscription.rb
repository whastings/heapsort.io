# == Schema Information
#
# Table name: category_subscriptions
#
#  id            :integer          not null, primary key
#  subscriber_id :integer          not null
#  category_id   :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#

class CategorySubscription < ActiveRecord::Base
  belongs_to :category
  belongs_to :subscriber, foreign_key: :subscriber_id, class_name: 'User'

  validates :subscriber, :category, presence: true
end
