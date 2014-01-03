class CategoriesController < ApplicationController

  def show
    @category = Category.friendly.find(params[:id])
  end

end
