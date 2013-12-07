require 'spec_helper'

describe AuthenticationHelper do
  let(:user) { get_test_user }

  describe "current_user" do
    specify { expect(current_user).to be_nil }

    context "when signed in" do
      before { sign_in(user) }
      specify { expect(current_user.id).to equal(user.id) }
    end

    context "when signed out" do
      before do
        sign_in(user)
        sign_out(user)
      end

      specify { expect(current_user).to be_nil }
    end
  end

end
