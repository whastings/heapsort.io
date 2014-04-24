# == Schema Information
#
# Table name: resources
#
#  id               :integer          not null, primary key
#  title            :string(150)      not null
#  domain           :string(75)       not null
#  path             :string(255)      default("/"), not null
#  query_string     :string(255)
#  port             :integer          default(80), not null
#  protocol         :string(10)       default("http"), not null
#  description      :text
#  user_id          :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#  slug             :string(255)
#  category_id      :integer
#  up_votes_count   :integer          default(0), not null
#  down_votes_count :integer          default(0), not null
#  resource_type_id :integer
#

class Resource < ActiveRecord::Base

  extend FriendlyId

  paginates_per 15
  friendly_id :title, use: :slugged

  # Associations:
  belongs_to :resource_type
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  # Validations:
  validates_presence_of :title, :domain, :category
  validates_numericality_of :port, { only_integer: true }
  validates :title, length: { maximum: 150 }
  validates :domain, length: { maximum: 75 }
  validates :path, :query_string, length: { maximum: 255 }
  validates :protocol, length: { maximum: 10 }
  validate :validate_url

  # Scopes:
  default_scope do
    select('resources.*, (up_votes_count - down_votes_count) AS rating')
      .order('rating DESC, resources.title')
  end

  scope :with_favorites, ->(user_id) do
    joins_query = <<-SQL
      LEFT OUTER JOIN
        favorites
      ON resources.id = favorites.resource_id
        AND favorites.user_id = '%s'
    SQL
    joins_query = self.sanitize_sql_for_conditions([joins_query, user_id])
    joins(joins_query).select('favorites.id AS favorite_id')
  end

  def category_tree
    ancestor_categories = self.category.ancestors.reverse
    ancestor_categories << self.category
    ancestor_categories
  end

  def url
    return @failed_url unless @failed_url.nil?
    return 'http://' if domain.blank?
    rendered_port = ([80, 443].include?(port)) ? '' : port
    assembled_url = URI::Generic.new(protocol, nil, domain, rendered_port, nil, path,
                                     nil, query_string, nil)
    assembled_url.to_s
  end

  def url=(url_string)
    parsed_url = nil
    begin
      parsed_url = URI.parse(url_string)
      raise URI::InvalidURIError if parsed_url.host.blank?
    rescue URI::InvalidURIError
      @failed_url = url_string
      return
    end
    @failed_url = nil
    self.protocol = parsed_url.scheme unless parsed_url.scheme.blank?
    self.domain = parsed_url.host
    self.path = parsed_url.path unless parsed_url.path.blank?
    self.port = parsed_url.port unless parsed_url.port.blank?
    self.query_string = parsed_url.query unless parsed_url.query.blank?
  end

  def normalize_friendly_id(string)
    resource_number = 1
    formatted_title = self.title.parameterize
    resource_title = formatted_title
    loop do
      existing_resource = self.class.find_by(slug: resource_title)
      break unless existing_resource
      resource_title = formatted_title + "-#{resource_number}"
      resource_number += 1
    end
    resource_title
  end

  private

    def validate_url
      unless @failed_url.nil?
        errors.add(:url, 'is invalid.')
        [:domain, :path, :port, :protocol].each do |attribute|
          errors.delete(attribute) if errors[attribute]
        end
      end
    end

end
