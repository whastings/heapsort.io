class CategoryDecorator < Draper::Decorator
  delegate_all

  def resources_count
    object.resources.count
  end

end
