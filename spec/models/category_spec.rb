# == Schema Information
#
# Table name: categories
#
#  id        :integer          not null, primary key
#  name      :string(100)      not null
#  parent_id :integer
#  slug      :string(255)
#

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

  describe "resources" do
    let(:attribute) { :resources }
    let(:category_with_resources) { FactoryGirl.create(:category) }
    let(:resources) { [] }
    before do
      10.times do
        resources << FactoryGirl.create(:resource, category_id: category_with_resources.id)
      end
    end
    subject { category_with_resources }

    it { should have_attribute(attribute) }
    its(:resources) { should == resources.reverse }
  end

end
