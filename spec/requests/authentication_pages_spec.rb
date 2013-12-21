require 'spec_helper'

describe "Authentication pages" do
  subject { page }

  describe "Sign in" do
    before { visit signin_path }
    let(:submit_button) { 'Sign in' }

    it { should have_page_title('Sign In') }

    context "with valid credentials" do
      let(:user) { get_test_user }
      before { perform_sign_in(user) }

      it { should have_success_message('Welcome!') }
    end

    context "with invalid credentials" do
      before { click_button submit_button }

      it { should have_page_title('Sign In') }
      it { should have_error_message('Incorrect email or password.') }
    end

  end

end
