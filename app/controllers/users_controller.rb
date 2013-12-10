class UsersController < ApplicationController
  include AuthenticationHelper

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      render text: 'User created!'
    else
      render text: 'Creation failed...', status: 400
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email,
                                   :password, :password_confirmation)
    end

end
