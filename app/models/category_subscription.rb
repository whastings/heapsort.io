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
  has_many :feed_items, through: :category, source: :resources

  validates :subscriber, :category, presence: true

  def category_name
    self.category.absolute_name
  end
end
