require 'spec_helper'

describe Resource do
  let(:resource) { FactoryGirl.create(:resource) }
  subject { resource }

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
    let(:resource_with_user) { FactoryGirl.create(:resource, user_id: user.id) }
    subject { resource_with_user }

    it { should have_attribute(attribute) }
    its(:user) { should == user }
  end

  describe "url" do
    let(:attribute) { :url }
    let(:url) { 'http://www.objectdotcreate.net:8080/a/url/path?this_is=a_test' }
    before { resource.url = url }

    it { should have_attribute(attribute) }
    its(:protocol) { should == 'http' }
    its(:domain) { should == 'www.objectdotcreate.net' }
    its(:port) { should == 8080 }
    its(:path) { should == '/a/url/path' }
    its(:query_string) { should == 'this_is=a_test' }
    its(:url) { should == url }

    context "with default http port" do
      before { resource.url = url.sub(':8080', '') }

      its(:url) { should_not =~ /:80\// }
    end

    describe "validations" do
      let(:bad_url) { 'http:www/this is one malformed url... com?' }
      before { resource.url = bad_url }

      it { should_not be_valid }
      specify do
        expect(resource.errors.keys).to_not include(*[
          :domain, :path, :port, :protocol
        ])
      end
    end
  end

  describe "slug" do
    let(:attribute) { :slug }

    it { should have_attribute(attribute) }
  end

  describe "category" do
    let(:attribute) { :category }
    let(:category) { FactoryGirl.create(:category) }
    let(:resource_with_category) do
      FactoryGirl.create(:resource, category_id: category.id)
    end
    subject { resource_with_category }

    it { should have_attribute(attribute) }
    its(:category) { should == category }
  end

end
