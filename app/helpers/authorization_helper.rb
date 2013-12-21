module AuthorizationHelper

  def restrict_to_signed_in
    if current_user.nil?
      render text: 'You must be signed in to do this.', status: 403
    end
  end

end
