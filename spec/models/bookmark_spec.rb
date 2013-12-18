require 'spec_helper'

describe Bookmark do
  let(:bookmark) { FactoryGirl.create(:bookmark) }
  subject { bookmark }

  it { should be_valid }

  describe "title" do
    let(:attribute) { :title }
    it { should have_attribute(attribute) }

    describe "validations" do
      let(:too_long) { 151 }

      it_should_behave_like "required attribute"
      it_should_behave_like "attribute with max length"
      it_should_behave_like "unique attribute"
    end
  end

  describe "domain" do
    let(:attribute) { :domain }
    it { should have_attribute(attribute) }

    describe "validations" do
      let(:too_long) { 76 }

      it_should_behave_like "required attribute"
      it_should_behave_like "attribute with max length"
    end
  end

  describe "path" do
    let(:attribute) { :path }
    it { should have_attribute(attribute) }

    describe "validations" do
      let(:too_long) { 256 }

      it_should_behave_like "required attribute"
      it_should_behave_like "attribute with max length"
    end
  end

  describe "query_string" do
    let(:attribute) { :query_string }
    it { should have_attribute(attribute) }

    describe "validations" do
      let(:too_long) { 256 }

      it_should_behave_like "attribute with max length"
    end
  end

  describe "port" do
    let(:attribute) { :port }
    it { should have_attribute(attribute) }

    describe "validations" do

      it_should_behave_like "required attribute"
      it_should_behave_like "numeric attribute"
    end
  end

  describe "protocol" do
    let(:attribute) { :protocol }
    it { should have_attribute(attribute) }

    describe "validations" do
      let(:too_long) { 11 }

      it_should_behave_like "required attribute"
      it_should_behave_like "attribute with max length"
    end
  end

  describe "description" do
    let(:attribute) { :description }
    it { should have_attribute(attribute) }
  end

  describe "user" do
    let(:attribute) { :user }
    let(:user) { get_test_user }
    let(:bookmark_with_user) { FactoryGirl.create(:bookmark, user_id: user.id) }
    subject { bookmark_with_user }

    it { should have_attribute(attribute) }
    its(:user) { should == user }
  end

end
