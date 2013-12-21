module WebDevBookmarks
  module Spec
    module UserUtils

      def get_test_user
        FactoryGirl.create(:user)
      end

      def get_new_user
        FactoryGirl.build(:user)
      end

      def sign_in(user)
        if example.metadata[:type] == :request
          visit signin_path
          perform_sign_in(user)
        else
          session = user.create_session!
          cookies[:token] = session.token
        end
      end

      def perform_sign_in(user)
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Sign in'
      end

      def sign_out(user)
        user.session.destroy
        cookies.delete(:token)
      end

      def user_created?(user)
        found_user = User.find_by_email(user.email)
        found_user && found_user.username == user.username
      end

    end
  end
end
