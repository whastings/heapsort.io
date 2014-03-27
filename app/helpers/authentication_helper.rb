module AuthenticationHelper

  def sign_in(user)
    token = user.sign_in
    cookies.permanent[:token] = {
      value: token,
      httponly: true
    }
    cookies.permanent[:signed_in] = true
  end

  def sign_out(user)
    user.sign_out
    @current_user = nil
    cookies.delete(:token)
    cookies.delete(:signed_in)
  end

  def current_user
    @current_user ||= Session.get_user_by_token(cookies[:token])
  end

end
