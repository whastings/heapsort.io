module AuthenticationHelper

  def sign_in(user)
    session = user.sessions.create
    cookies.permanent[:token] = {
      value: session.token,
      httponly: true
    }
    cookies.permanent[:signed_in] = true
  end

  def sign_out(user)
    @current_user = nil
    session = Session.find_by(token: cookies[:token])
    session && session.destroy
    cookies.delete(:token)
    cookies.delete(:signed_in)
  end

  def current_user
    @current_user ||= Session.get_user_by_token(cookies[:token])
  end

end
