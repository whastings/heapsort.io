module Postable
  extend ActiveSupport::Concern

  def author
    object.user.username
  end

  def posted
    h.l(object.created_at, format: :date_with_time)
  end

  def posted_ago
    h.time_ago_in_words(object.created_at)
  end
end
