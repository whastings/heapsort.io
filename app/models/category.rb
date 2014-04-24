# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(100)      not null
#  parent_id  :integer
#  slug       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base

  extend FriendlyId

  friendly_id :absolute_name, use: :slugged

  # Associations:
  belongs_to :parent, foreign_key: :parent_id,
             class_name: 'Category', touch: true
  has_many(
    :children,
    foreign_key: :parent_id,
    class_name: 'Category',
    dependent: :destroy
  )
  has_many :resources, dependent: :destroy

  # Validations:
  validates :name, presence: true, length: { maximum: 100 }

  # Scopes:
  default_scope -> { order(:name) }

  def absolute_name
    category_names = [self.name]
    self.ancestors.each do |ancestor|
      category_names << ancestor.name
    end
    category_names.reverse.join('/')
  end

  def ancestors
    ancestors_query = <<-SQL
      WITH RECURSIVE ancestors(id, name, parent_id, slug) AS (
        SELECT
          id, name, parent_id, slug
        FROM
          categories
        WHERE
          id = ?
      UNION ALL
        SELECT
          categories.id, categories.name, categories.parent_id, categories.slug
        FROM
          ancestors
        INNER JOIN
          categories
        ON
          categories.id = ancestors.parent_id
      )
      SELECT * FROM ancestors
    SQL
    self.class.find_by_sql([ancestors_query, self.parent_id])
  end

  def normalize_friendly_id(string)
    parts = string.split('/')
    parts.map! do |part|
      part.parameterize
    end
    parts.join('/')
  end
end
