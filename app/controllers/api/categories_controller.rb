class Api::CategoriesController < ApplicationController
  def show
    if params[:id].to_i == 0
      @category = Category.new(name: 'root')
      @children = Category.where(parent_id: nil)
      @resources = []
    else
      @category = Category.where(id: params[:id]).eager_load(:children).first
      @children = @category.children
      @resources = @category.resources.eager_load(:user).paginate(page: 1).decorate
    end
  end
end
