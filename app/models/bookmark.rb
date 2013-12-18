# == Schema Information
#
# Table name: bookmarks
#
#  id           :integer          not null, primary key
#  title        :string(150)      not null
#  domain       :string(75)       not null
#  path         :string(255)      default("/"), not null
#  query_string :string(255)
#  port         :integer          default(80), not null
#  protocol     :string(10)       default("http"), not null
#  description  :text
#  user_id      :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Bookmark < ActiveRecord::Base

  # Associations:
  belongs_to :user

  # Validations:
  validates_presence_of :title, :domain, :path, :port, :protocol
  validates_uniqueness_of :title
  validates_numericality_of :port, { only_integer: true }
  validates :title, length: { maximum: 150 }
  validates :domain, length: { maximum: 75 }
  validates :path, :query_string, length: { maximum: 255 }
  validates :protocol, length: { maximum: 10 }

end
