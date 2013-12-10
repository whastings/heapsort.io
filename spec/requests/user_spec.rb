require 'spec_helper'

describe "User requests" do
  subject { response }

  describe "Sign up" do
    let(:email) { 'will@example.com' }
    let(:username) { 'willh' }
    let(:info) do
      {
        user: { username: username, email: email,
                password: 'foobar', password_confirmation: 'foobar' }
      }
    end

    context "with valid information" do
      before { post users_path, info }

      its(:status) { should == 200 }
      its(:cookies) { should include('token') }
      specify { expect(User.find_by_email(email).username).to eq(username) }
    end

    context "with invalid information" do
      before do
        info[:user][:username] = ''
        info[:user][:password_confirmation] = 'barbaz'
        post users_path, info
      end

      its(:status) { should == 400 }
      its(:cookies) { should_not include('token') }
      specify { expect(User.find_by_email(email)).to be_nil }
    end

  end

end
