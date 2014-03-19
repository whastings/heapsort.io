class ResourcesController < ApplicationController

  include AuthenticationHelper
  include AuthorizationHelper

  # Filters:
  before_filter :restrict_to_signed_in, only: [:new, :create]

  def index
    @resources = Resource.paginate(page: params[:page])
  end

  def show
    @resource = Resource.friendly.find(params[:id])
  end

  def new
    @resource = current_user.resources.build
  end

  def create
    @resource = current_user.resources.build(resource_params)
    if @resource.save
      flash[:success] = 'Resource added!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

    def resource_params
      params.require(:resource).permit(:title, :url, :description)
    end

end
