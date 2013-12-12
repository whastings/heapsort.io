class SessionsController < ApplicationController
  include AuthenticationHelper

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      sign_in(user)
      flash[:success] = 'Welcome!'
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

end
