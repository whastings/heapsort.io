module Admin
  class CategoryDecorator < Draper::Decorator
    decorates ::Category
    delegate_all

    def name
      self.full_name
    end
  end
end

