require 'spec_helper'

describe "Authentication" do
  let(:user) { get_test_user }
  subject { response }

  describe "signing in" do

    shared_examples_for "failed signin" do
      before { post sessions_path, credentials }

      its(:status) { should == 403 }
      its(:cookies) { should_not include('token') }
      specify { expect(user.session).to be_nil }
    end

    specify { expect(user.session).to be_nil }

    context "with valid credentials" do
      let(:credentials) { {email: user.email, password: user.password} }
      before do
        post sessions_path, credentials
        user.reload
      end

      its(:status) { should == 200 }
      its(:cookies) { should include('token') }
      specify { expect(response.cookies['token']).to_not be_nil }
      specify { expect(user.session).to_not be_nil }
    end

    context "with nonexistent user" do
      let(:bad_email) { 'nobody@nothing.com' }
      let(:credentials) { {email: bad_email, password: user.password} }

      it_should_behave_like "failed signin"
    end

    context "with wrong password" do
      let(:credentials) { {email: user.email, password: 'wrong_pass'} }

      it_should_behave_like "failed signin"
    end

  end

  describe "signing out" do
    before do
      sign_in(user)
      delete signout_path
      user.reload
    end

    its(:status) { should == 200 }
    its(:cookies) { should include('token') }
    specify { expect(response.cookies['token']).to be_nil }
    specify { expect(user.session).to be_nil }
  end

end
