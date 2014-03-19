class Api::CategoriesController < ApplicationController
  def show
    @category = Category.where(id: params[:id]).eager_load(:children).first
    @resources = @category.resources.paginate(page: 1)
  end
end
