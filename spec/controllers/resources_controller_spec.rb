require 'spec_helper'

describe ResourcesController do
  let(:user) { get_test_user }
  before { sign_in(user) }
  subject { response }

  describe "creating a resource" do
    let(:resource) { FactoryGirl.build(:resource) }
    let(:resource_info) do
      {resource: {
        title: resource.title,
        url: resource.url
      }}
    end

    context "with valid info" do
      before do
        post :create, resource_info
        user.reload
      end

      it { should redirect_to(root_path) }
      specify { expect(resource).to have_been_created }
    end

    context "with invalid info" do
      before do
        resource_info[:resource].delete(:url)
        post :create, resource_info
      end

      specify { expect(resource).to_not have_been_created }
    end

    context "when signed out" do
      before do
        sign_out(user)
        post :create, resource_info
      end

      its(:status) { should == 403 }
      specify { expect(resource).to_not have_been_created }
    end

  end

  describe "index" do
    let(:resources) { [] }
    before do
      3.times do |n|
        resources << FactoryGirl.create(:resource, created_at: Time.now.to_i + n)
      end
      get :index
    end

    its(:status) { should == 200 }
    specify { expect(assigns(:resources)).to eq(resources.reverse) }
  end

  describe "show" do
    let(:resource) { FactoryGirl.create(:resource) }
    before { get :show, id: resource.id }

    its(:status) { should == 200 }
    specify { expect(assigns(:resource)).to eq(resource) }
  end

end
