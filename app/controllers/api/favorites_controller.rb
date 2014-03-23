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

  private

  def favorite_params
    params.require(:favorite).permit(:resource_id)
  end
end
