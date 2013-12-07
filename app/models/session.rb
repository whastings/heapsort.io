# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  token      :string(24)       not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Session < ActiveRecord::Base

  # Associations:
  belongs_to :user

  # Validations:
  validates_presence_of :token, :user_id
  validates_uniqueness_of :token, :user_id

  # Callbacks:
  after_initialize :generate_token

  def self.get_user_by_token(token)
    session = where(token: token).first
    session.user unless session.nil?
  end

  private

    def generate_token
      self.token = SecureRandom.urlsafe_base64
    end

end
