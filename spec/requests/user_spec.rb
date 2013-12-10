require 'spec_helper'

describe "User requests" do
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
      before { post users_path, info }

      its(:status) { should == 200 }
      its(:cookies) { should include('token') }
      specify { expect(user).to have_been_created }
    end

    context "with invalid information" do
      before do
        info[:user][:username] = ''
        info[:user][:password_confirmation] = 'barbaz'
        post users_path, info
      end

      its(:status) { should == 400 }
      its(:cookies) { should_not include('token') }
      specify { expect(user).to not_exist }
    end

  end

end
