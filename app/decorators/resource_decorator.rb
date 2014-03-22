class ResourceDecorator < Draper::Decorator
  delegate_all
  include Postable

  def pretty_url
    object.url.sub(/^https?:\/\//, '').sub(/\/$/, '')
  end
end
