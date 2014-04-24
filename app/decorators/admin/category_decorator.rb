module Admin
  class CategoryDecorator < Draper::Decorator
    decorates ::Category
    delegate_all

    def name
      "#{object.name} (#{object.friendly_id})"
    end
  end
end

