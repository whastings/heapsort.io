class UsersController < ApplicationController
  include AuthenticationHelper

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:js_notice] = 'Account created successfully!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email,
                                   :password, :password_confirmation)
    end

end
