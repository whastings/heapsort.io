class Api::FavoritesController < ApplicationController
  include AuthenticationHelper

  def create
    favorite = Favorite.new(favorite_params)
    favorite.user_id = current_user.id
    if favorite.save
      render json: favorite
    else
      render json: favorite.errors.full_messages
    end
  end

  def destroy
    favorite = Favorite.find(params[:id])
    return unless favorite.user_id == current_user.id
    favorite.destroy
    render json: favorite
  end

  def index
    @resources = current_user.favorite_resources
      .select('favorites.id AS favorite_id').decorate
    render 'api/resources/index'
  end

  private

  def favorite_params
    params.require(:favorite).permit(:resource_id)
  end
end
