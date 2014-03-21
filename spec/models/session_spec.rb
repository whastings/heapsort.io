# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  token      :string(24)       not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Session do

  let(:user) { get_test_user }
  let(:session) { Session.new(user_id: user.id) }
  subject { session }

  it { should be_valid }

  describe "token" do
    let(:attribute) { :token }
    it { should have_attribute(attribute) }

    describe "validations" do
      it_should_behave_like "required attribute"
      it_should_behave_like "unique attribute"
    end
  end

  describe "user_id" do
    let(:attribute) { :user_id }

    describe "validations" do
      it_should_behave_like "required attribute"
      it_should_behave_like "unique attribute"
    end
  end

  describe "user" do
    let(:attribute) { :user }
    it { should have_attribute(attribute) }
    its(:user) { should == user }
  end

  describe "Session.get_user_by_token" do
    let(:session_user) { Session.get_user_by_token(session.token) }
    before { session.save! }
    specify { expect(session_user.id).to equal(user.id) }

    context "with invalid token" do
      let(:invalid_token) { 'invalid_token' }
      specify { expect(Session.get_user_by_token(invalid_token)).to be_nil }
    end
  end

end
