module WebDevBookmarks
  module Spec
    module UserUtils

      def get_test_user
        FactoryGirl.create(:user)
      end

      def sign_in(user)
        session = user.create_session!
        cookies[:token] = session.token
      end

      def sign_out(user)
        user.session.destroy
        cookies.delete(:token)
      end

    end
  end
end
