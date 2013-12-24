# == Schema Information
#
# Table name: categories
#
#  id        :integer          not null, primary key
#  name      :string(100)      not null
#  parent_id :integer
#

class Category < ActiveRecord::Base

  # Associations:
  belongs_to :parent, foreign_key: :parent_id, class_name: 'Category'
  has_many :children, foreign_key: :parent_id, class_name: 'Category'
  has_many :bookmarks

  # Validations:
  validates :name, presence: true, length: { maximum: 100 }

  # Scopes:
  default_scope -> { order(:name) }

end
