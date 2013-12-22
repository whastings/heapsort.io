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

  describe "Bookmark Index" do
    let(:bookmarks) { Bookmark.all }
    before do
      3.times { FactoryGirl.create(:bookmark) }
      visit bookmarks_path
    end

    it { should have_page_title('Latest Bookmarks') }
    it "should render the latest bookmarks" do
      bookmarks.each { |bookmark| should show_bookmark(bookmark) }
    end

    context "with many bookmarks" do
      let(:paged_bookmarks) { Bookmark.limit(15) }
      let(:missing_bookmark) { Bookmark.offset(15).limit(1).first }
      before do
        30.times { FactoryGirl.create(:bookmark) }
        visit bookmarks_path
      end

      it "should only render the first 15 bookmarks" do
        paged_bookmarks.each { |bookmark| should show_bookmark(bookmark) }
      end
      it { should_not show_bookmark(missing_bookmark) }
      it { should have_pagination }
    end
  end

  describe "Bookmark View" do
    let(:bookmark) { FactoryGirl.create(:bookmark) }
    before { visit bookmark_path(bookmark) }

    it { should show_full_bookmark(bookmark) }
  end

end
