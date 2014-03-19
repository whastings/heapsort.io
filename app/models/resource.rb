# == Schema Information
#
# Table name: resources
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
#  slug         :string(255)
#  category_id  :integer
#

class Resource < ActiveRecord::Base

  extend FriendlyId

  self.per_page = 15
  friendly_id :title, use: :slugged

  # Associations:
  belongs_to :user
  belongs_to :category

  # Validations:
  validates_presence_of :title, :domain, :path, :port, :protocol
  validates_numericality_of :port, { only_integer: true }
  validates :title, length: { maximum: 150 }
  validates :domain, length: { maximum: 75 }
  validates :path, :query_string, length: { maximum: 255 }
  validates :protocol, length: { maximum: 10 }
  validate :validate_url

  # Scopes:
  default_scope { order('created_at DESC') }

  def url
    return @failed_url unless @failed_url.nil?
    return 'http://' if domain.blank?
    rendered_port = (port == 80) ? '' : port
    assembled_url = URI::Generic.new(protocol, nil, domain, rendered_port, nil, path,
                                     nil, query_string, nil)
    assembled_url.to_s
  end

  def url=(url_string)
    parsed_url = nil
    begin
      parsed_url = URI.parse(url_string)
    rescue URI::InvalidURIError => error
      @failed_url = url_string
      return
    end
    @failed_url = nil
    self.protocol = parsed_url.scheme
    self.domain = parsed_url.host
    self.path = parsed_url.path.blank? ? '/' : parsed_url.path
    self.port = parsed_url.port
    self.query_string = parsed_url.query
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
