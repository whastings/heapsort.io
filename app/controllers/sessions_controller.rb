class SessionsController < ApplicationController
  include AuthenticationHelper

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      reset_session # Prevents session fixation.
      sign_in(user)
      redirect_to root_path
    else
      flash.now[:error] = 'Incorrect email or password.'
      render 'new'
    end
  end

  def destroy
    sign_out(current_user) unless current_user.nil?
    redirect_to root_path
  end

  def sign_in_guest
    unless ENV['HEAPSORT_GUEST_ENABLED']
      render(
        file: File.join(Rails.root, 'public/403.html'),
        status: 403,
        layout: false
      )
      return
    end
    user = User.find_by(username: 'guest')
    user && sign_in(user)
    redirect_to root_path
  end

end
