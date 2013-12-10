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

RSpec::Matchers.define(:have_been_created) do
  match do |user|
    expect(User.find_by_email(user.email).username).to eq(user.username)
  end
end

RSpec::Matchers.define(:not_exist) do
  match do |user|
    expect(User.find_by_email(user.email)).to be_nil
  end
end
