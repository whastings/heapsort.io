# == Schema Information
#
# Table name: resource_types
#
#  id         :integer          not null, primary key
#  name       :string(50)
#  created_at :datetime
#  updated_at :datetime
#

class ResourceType < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true

  has_many :resources

  default_scope -> { order(:name) }
end
