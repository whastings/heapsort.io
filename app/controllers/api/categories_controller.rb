class Api::CategoriesController < ApplicationController
  include AuthenticationHelper

  def index
    @categories = Category.all
    render 'api/categories/index'
  end

  def show
    if params[:id] == '0'
      @category = Category.new(name: 'root').decorate
      @children = Category.where(parent_id: nil)
      @resources = []
    else
      @category = Category.where(slug: params[:id])
        .eager_load(:children).first.decorate
      @children = @category.children
      @resources = @category.resources.includes(:user).page(1)
      if current_user
        @resources = @resources.with_favorites(current_user.id)
      end
      @resources = @resources.decorate
    end
  end
end
