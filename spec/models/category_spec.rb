require 'spec_helper'

describe Category do
  let(:category) { FactoryGirl.create(:category) }
  subject { category }

  it { should be_valid }

  describe "name" do
    let(:attribute) { :name }
    let(:too_long) { 101 }
    it { should have_attribute(attribute) }

    it_should_behave_like "required attribute"
    it_should_behave_like "attribute with max length"
  end

  describe "parent" do
    let(:attribute) { :parent }
    let(:parent_category) { FactoryGirl.create(:category) }
    let(:category_with_parent) do
      FactoryGirl.create(:category, parent_id: parent_category.id)
    end
    subject { category_with_parent }

    it { should have_attribute(attribute) }
    its(:parent) { should == parent_category }
  end

  describe "children" do
    let(:attribute) { :children }
    let(:category_with_children) { FactoryGirl.create(:category) }
    let(:children) { [] }
    before do
      FactoryGirl.reload
      5.times do
        children << FactoryGirl.create(:category, parent_id: category_with_children.id)
      end
    end
    subject { category_with_children }

    it { should have_attribute(attribute) }
    its(:children) { should == children }
  end

  describe "bookmarks" do
    let(:attribute) { :bookmarks }
    let(:category_with_bookmarks) { FactoryGirl.create(:category) }
    let(:bookmarks) { [] }
    before do
      10.times do
        bookmarks << FactoryGirl.create(:bookmark, category_id: category_with_bookmarks.id)
      end
    end
    subject { category_with_bookmarks }

    it { should have_attribute(attribute) }
    its(:bookmarks) { should == bookmarks.reverse }
  end

end
