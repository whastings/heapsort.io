class Api::VotesController < ApplicationController
  include AuthenticationHelper

  def create
    new_rating = Vote.record_vote(
      params[:resource_id],
      current_user.id,
      params[:direction]
    )
    if new_rating
      render json: { new_rating: new_rating }
    else
      head :unprocessable_entity
    end
  end
end
