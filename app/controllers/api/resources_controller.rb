
class Api::ResourcesController < ApplicationController
  def index
    @resources = Resource.paginate(page: params[:page]).decorate
    render "resources/index"
  end
end

