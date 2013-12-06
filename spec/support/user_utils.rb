module WebDevBookmarks
  module Spec
    module UserUtils

      def get_test_user
        FactoryGirl.create(:user)
      end

    end
  end
end
