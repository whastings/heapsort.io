require 'spec_helper'

describe "Resource pages" do
  let(:user) { get_test_user }
  before { sign_in(user) }
  subject { page }

  describe "Add resource" do
    let(:resource) { FactoryGirl.build(:resource) }
    let(:submit_button) { 'Share!' }
    before { visit add_resource_path }

    it { should have_page_title('Share a Resource') }

    context "with valid info" do
      before do
        fill_in 'Title', with: resource.title
        fill_in 'URL', with: resource.url
        fill_in 'Description', with: resource.description
        click_button submit_button
      end

      it { should have_success_message('Resource added!') }
      specify { expect(resource).to have_been_created }
    end

    context "with invalid info" do
      before { click_button submit_button }

      it { should have_page_title('Share a Resource') }
      it { should have_error_message('The form contains') }
      it { should have_error_list }
      specify { expect(resource).to_not have_been_created }
    end
  end

  describe "Resource Index" do
    let(:resources) { Resource.all }
    before do
      3.times { FactoryGirl.create(:resource) }
      visit resources_path
    end

    it { should have_page_title('Latest Resources') }
    it "should render the latest resources" do
      resources.each { |resource| should show_resource(resource) }
    end

    context "with many resources" do
      let(:paged_resources) { Resource.limit(15) }
      let(:missing_resource) { Resource.offset(15).limit(1).first }
      before do
        30.times { FactoryGirl.create(:resource) }
        visit resources_path
      end

      it "should only render the first 15 resources" do
        paged_resources.each { |resource| should show_resource(resource) }
      end
      it { should_not show_resource(missing_resource) }
      it { should have_pagination }
    end
  end

  describe "Resource View" do
    let(:resource) { FactoryGirl.create(:resource) }
    before { visit resource_path(resource) }

    it { should show_full_resource(resource) }
  end

end
