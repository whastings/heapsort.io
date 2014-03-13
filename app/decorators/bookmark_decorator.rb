class BookmarkDecorator < Draper::Decorator
  delegate_all

  def link
    h.link_to object.title, object
  end

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
