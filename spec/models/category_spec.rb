# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(100)      not null
#  parent_id  :integer
#  slug       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Category do
  subject(:category) { build(:category) }
  let(:names) { ('a'..'d').to_a.reverse }
  before do
    categories = []
    names.each_with_index do |name, index|
      parent_id = (index.zero?) ? nil : categories[index - 1].id
      categories << create(:category, name: name, parent_id: parent_id)
    end
  end

  it { should be_valid }

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_most(100) }
  end

  describe "associations" do
    it { should belong_to(:parent).class_name('Category') }
    it { should have_many(:children).class_name('Category') }
    it { should have_many(:resources) }
  end

  describe "default_scope" do

    it "orders by name ascending" do
      expect(Category.all.pluck(:name)).to eq(names.reverse)
    end
  end

  describe "#absolute_name" do
    it "creates name from ancestors" do
      expect(Category.first.absolute_name).to eq(names.join('/'))
    end
  end

  describe "#ancestors" do
    it "retrieves category's parent, parent's parent, etc." do
      expect(Category.first.ancestors.map(&:name)).to eq(names[0..-2].reverse)
    end
  end
end
