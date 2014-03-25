# == Schema Information
#
# Table name: categories
#
#  id        :integer          not null, primary key
#  name      :string(100)      not null
#  parent_id :integer
#  slug      :string(255)
#

class Category < ActiveRecord::Base

  extend FriendlyId

  friendly_id :name, use: :slugged

  # Associations:
  belongs_to :parent, foreign_key: :parent_id, class_name: 'Category'
  has_many :children, foreign_key: :parent_id, class_name: 'Category'
  has_many :resources

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
      WITH RECURSIVE ancestors(id, name, parent_id) AS (
        SELECT
          id, name, parent_id
        FROM
          categories
        WHERE
          id = ?
      UNION ALL
        SELECT
          categories.id, categories.name, categories.parent_id
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

end
