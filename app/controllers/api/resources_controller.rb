
class Api::ResourcesController < ApplicationController
  def index
    @resources = Resource.where(category_id: params[:category_id])
      .paginate(page: params[:page]).decorate
    render "api/resources/index"
  end
end

