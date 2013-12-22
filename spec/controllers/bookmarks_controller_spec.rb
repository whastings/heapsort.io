require 'spec_helper'

describe BookmarksController do
  let(:user) { get_test_user }
  before { sign_in(user) }
  subject { response }

  describe "creating a bookmark" do
    let(:bookmark) { FactoryGirl.build(:bookmark) }
    let(:bookmark_info) do
      {bookmark: {
        title: bookmark.title,
        url: bookmark.url
      }}
    end

    context "with valid info" do
      before do
        post :create, bookmark_info
        user.reload
      end

      it { should redirect_to(root_path) }
      specify { expect(bookmark).to have_been_created }
    end

    context "with invalid info" do
      before do
        bookmark_info[:bookmark].delete(:url)
        post :create, bookmark_info
      end

      specify { expect(bookmark).to_not have_been_created }
    end

    context "when signed out" do
      before do
        sign_out(user)
        post :create, bookmark_info
      end

      its(:status) { should == 403 }
      specify { expect(bookmark).to_not have_been_created }
    end

  end

  describe "index" do
    let(:bookmarks) { [] }
    before do
      3.times do |n|
        bookmarks << FactoryGirl.create(:bookmark, created_at: Time.now.to_i + n)
      end
      get :index
    end

    its(:status) { should == 200 }
    specify { expect(assigns(:bookmarks)).to eq(bookmarks.reverse) }
  end

  describe "show" do
    let(:bookmark) { FactoryGirl.create(:bookmark) }
    before { get :show, id: bookmark.id }

    its(:status) { should == 200 }
    specify { expect(assigns(:bookmark)).to eq(bookmark) }
  end

end
