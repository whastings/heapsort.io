class CategoryDecorator < Draper::Decorator
  delegate_all

  def parent_friendly_id
    object.parent ? object.parent.friendly_id : 0
  end

  def resources_count
    object.resources.count
  end

end
