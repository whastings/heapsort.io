require 'spec_helper'

describe "Bookmark pages" do
  let(:user) { get_test_user }
  before { sign_in(user) }
  subject { page }

  describe "Add bookmark" do
    let(:bookmark) { FactoryGirl.build(:bookmark) }
    let(:submit_button) { 'Share!' }
    before { visit add_bookmark_path }

    it { should have_page_title('Share a Bookmark') }

    context "with valid info" do
      before do
        fill_in 'Title', with: bookmark.title
        fill_in 'URL', with: bookmark.url
        fill_in 'Description', with: bookmark.description
        click_button submit_button
      end

      it { should have_success_message('Bookmark added!') }
      specify { expect(bookmark).to have_been_created }
    end

    context "with invalid info" do
      before { click_button submit_button }

      it { should have_page_title('Share a Bookmark') }
      it { should have_error_message('The form contains') }
      it { should have_error_list }
      specify { expect(bookmark).to_not have_been_created }
    end
  end

end
