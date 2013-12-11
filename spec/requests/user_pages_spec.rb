require 'spec_helper'

describe "User pages" do
  subject { page }

  describe "Sign up" do
    before { visit signup_path }
    let(:submit_button) { 'Sign up' }

    it { should have_page_title('Sign Up') }

    context "with valid information" do
      let(:user) { get_new_user }
      before do
        fill_in 'Username', with: user.username
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Confirm Password', with: user.password_confirmation
        click_button submit_button
      end

      it { should have_success_message('Account created successfully!') }
      specify { expect(user).to have_been_created }
    end

    context "with invalid information" do
      specify do
        expect { click_button submit_button }.to_not change(User, :count)
      end
      describe "submission" do
        before { click_button submit_button }

        it { should have_page_title('Sign Up') }
        it { should have_error_message('The form contains') }
        it { should have_error_list }
      end
    end

  end

end
