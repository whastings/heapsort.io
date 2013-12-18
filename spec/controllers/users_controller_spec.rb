require 'spec_helper'

describe UsersController do
  subject { response }

  describe "Sign up" do
    let(:user) { get_new_user }
    let(:info) do
      {
        user: { username: user.username, email: user.email,
                password: user.password, password_confirmation: user.password }
      }
    end

    context "with valid information" do
      before { post :create, info }

      it { should redirect_to root_path }
      its(:cookies) { should include('token') }
      specify { expect(user).to have_been_created }
    end

    context "with invalid information" do
      before do
        info[:user][:username] = ''
        info[:user][:password_confirmation] = 'barbaz'
        post :create, info
      end

      its(:cookies) { should_not include('token') }
      specify { expect(user).to not_exist }
    end

    context "with existing user information" do
      let(:existing_user) { get_test_user }
      before do
        info[:user][:username] = existing_user.username
        info[:user][:email] = existing_user.email
      end

      specify do
        expect { post :create, info }.to_not change(User, :count)
      end
    end

  end

end
