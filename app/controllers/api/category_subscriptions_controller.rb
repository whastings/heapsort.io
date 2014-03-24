class Api::CategorySubscriptionsController < ApplicationController
  include AuthenticationHelper

  def create
    category_subscription = CategorySubscription.new
    category_subscription.category_id = params[:category_id]
    category_subscription.subscriber_id = current_user.id
    if category_subscription.save
      render json: category_subscription
    else
      render json: category_subscription.errors.full_messages,
             status: :unprocessable_entity
    end
  end
end
