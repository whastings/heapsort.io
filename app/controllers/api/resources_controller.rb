
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

  def feed
    @resources = current_user.category_feed_items.includes(:user)
      .with_favorites(current_user.id).reorder('created_at DESC')
      .page(params[:page]).decorate
    if (params[:page].nil? || params[:page].to_i == 1)
      @total = current_user.category_feed_items.count
    end
    render 'api/resources/index'
  end

  def index
    @resources = Resource.where(category_id: params[:category_id])
      .includes(:user).page(params[:page])
    if current_user
      @resources = @resources.with_favorites(current_user.id)
    end
    @resources = @resources.decorate
    render "api/resources/index"
  end

  def show
    @resource = Resource.where(slug: params[:id])
    if current_user
      @resource = @resource.with_favorites(current_user.id)
    end
    @resource = @resource.first.decorate
    @comments = @resource.comments.includes(:user).decorate
  end

  private

  def resource_params
    params.permit(:title, :url, :description, :resource_type_id, :category_id)
  end
end

