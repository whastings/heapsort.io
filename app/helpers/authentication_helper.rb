module AuthenticationHelper

  def sign_in(user)
    token = user.sign_in
    cookies.permanent[:token] = token
  end

  def sign_out(user)
    user.sign_out
    @current_user = nil
    cookies.delete(:token)
  end

  def current_user
    @current_user ||= Session.get_user_by_token(cookies[:token])
  end

end
