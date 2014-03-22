class Api::CommentsController < ApplicationController
  include AuthenticationHelper

  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.resource_id = params[:resource_id]
    if comment.save
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
