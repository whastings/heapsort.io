require 'spec_helper'

describe User do
  let(:user) { get_test_user }
  subject { user }

  it { should be_valid }

  describe "username" do
    let(:attribute) { :username }
    it { should have_attribute(attribute) }

    describe "validations" do
      let(:too_long) { 51 }

      it_should_behave_like "required attribute"
      it_should_behave_like "attribute with max length"
      it_should_behave_like "unique attribute"

      context "with disallowed characters" do
        let(:bad_usernames) { ['$ammy', 'John Smith', 'A/B'] }
        it "should catch each invalid username" do
          bad_usernames.each do |username|
            user.username = username
            should_not be_valid
          end
        end
      end
    end
  end

  describe "email" do
    let(:attribute) { :email }
    it { should have_attribute(attribute) }

    describe "validations" do
      let(:too_long) { 101 }

      it_should_behave_like "required attribute"
      it_should_behave_like "attribute with max length"
      it_should_behave_like "unique attribute"

      context "with disallowed characters" do
        it "should catch invalid email addresses" do
          addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
          addresses.each do |invalid_address|
            user.email = invalid_address
            should_not be_valid
          end
        end
      end
    end
  end

  describe "admin" do
    let(:attribute) { :admin }

    it { should have_attribute(attribute) }
    it { should respond_to(:admin?) }
    it { should_not be_admin }
  end

  describe "blocked" do
    let(:attribute) { :blocked }

    it { should have_attribute(attribute) }
    it { should respond_to(:blocked?) }
    it { should_not be_blocked }
  end

  describe "session" do
    let(:attribute) { :session }
    let(:session) { user.session }
    before { user.create_session }

    it { should have_attribute(attribute) }
    specify { expect(session.user_id).to equal(user.id) }
  end

  describe "sign_out" do
    before do
      user.sign_in
      user.sign_out
    end
    its(:session) { should be_nil }
  end

end
