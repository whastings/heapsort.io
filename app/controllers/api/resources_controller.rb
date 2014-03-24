
class Api::ResourcesController < ApplicationController
  include AuthenticationHelper

  def create
    resource = Resource.new(resource_params)
    resource.user_id = current_user.id
    if resource.save
      render json: resource
    else
      render json: resource.errors.full_messages, status: :unprocessable_entity
    end
  end

  def index
    @resources = Resource.where(category_id: params[:category_id])
      .paginate(page: params[:page])
    if current_user
      @resources = @resources.with_favorites(current_user.id)
    end
    @resources = @resources.decorate
    render "api/resources/index"
  end

  def show
    @resource = Resource.where(id: params[:id])
    if current_user
      @resource = @resource.with_favorites(current_user.id)
    end
    @resource = @resource.first.decorate
    @comments = @resource.comments.includes(:user).decorate
  end

  private

  def resource_params
    params.permit(:title, :url, :description)
  end
end

