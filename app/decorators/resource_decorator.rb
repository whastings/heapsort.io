class ResourceDecorator < Draper::Decorator
  delegate_all
  include Postable

  def favorite_id
    object.respond_to?(:favorite_id) ? object.favorite_id : nil
  end

  def pretty_url
    object.url.sub(/^https?:\/\//, '').sub(/\/$/, '')
  end
end
