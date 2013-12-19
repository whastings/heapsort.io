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

  def url
    assembled_url = URI::Generic.new(protocol, nil, domain, port, nil, path,
                                     nil, query_string, nil)
    assembled_url.to_s
  end

  def url=(url_string)
    parsed_url = URI.parse(url_string)
    self.protocol = parsed_url.scheme
    self.domain = parsed_url.host
    self.path = parsed_url.path
    self.port = parsed_url.port
    self.query_string = parsed_url.query
  end

end
