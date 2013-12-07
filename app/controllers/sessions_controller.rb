class SessionsController < ApplicationController
  include AuthenticationHelper

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      sign_in(user)
      render text: 'Session created!'
    else
      render text: 'Creation failed...', status: 403
    end
  end

  def destroy
    sign_out(current_user) unless current_user.nil?
    render text: 'Session destroyed!'
  end

end
