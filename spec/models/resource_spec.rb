# == Schema Information
#
# Table name: resources
#
#  id               :integer          not null, primary key
#  title            :string(150)      not null
#  domain           :string(75)       not null
#  path             :string(255)      default("/"), not null
#  query_string     :string(255)
#  port             :integer          default(80), not null
#  protocol         :string(10)       default("http"), not null
#  description      :text
#  user_id          :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#  slug             :string(255)
#  category_id      :integer
#  up_votes_count   :integer          default(0), not null
#  down_votes_count :integer          default(0), not null
#  resource_type_id :integer
#

require 'spec_helper'

describe Resource do
  subject(:resource) { create(:resource) }
  it { should be_valid }

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should ensure_length_of(:title).is_at_most(150) }

    it { should validate_presence_of(:domain) }
    it { should ensure_length_of(:domain).is_at_most(75) }

    it { should ensure_length_of(:path).is_at_most(255) }

    it { should ensure_length_of(:query_string).is_at_most(255) }

    it { should validate_numericality_of(:port) }

    it { should ensure_length_of(:protocol).is_at_most(10) }
  end

  describe "associations" do
    it { should belong_to(:resource_type) }
    it { should belong_to(:user) }
    it { should belong_to(:category) }

    it { should have_many(:comments) }
    it { should have_many(:votes) }
  end

  describe "url" do
    let(:url) { 'http://www.objectdotcreate.net:8080/a/url/path?this_is=a_test' }
    before { resource.url = url }

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

    context "with https" do
      before do
        resource.url = url.sub(':8080', '').sub('http', 'https')
      end

      its(:url) { should_not =~ /:443\// }
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

  describe "default_scope" do
    before do
      create(:resource, up_votes_count: 5, down_votes_count: 15, title: 'A')
      create(:resource, title: 'D')
      create(:resource, title: 'C')
      create(:resource, title: 'B')
      create(:resource, title: 'F', down_votes_count: 5, up_votes_count: 15)
      create(:resource, title: 'G', up_votes_count: 25)
    end

    it "orders by rating descending, then by title" do
      resources = Resource.all
      expect(resources.map(&:title)).to eq(['G', 'F', 'B', 'C', 'D', 'A'])
    end
  end

  describe "::with_favorites" do
    let(:user) { create(:user) }
    before do
      resources = []
      5.times { resources << create(:resource) }
      3.times do |index|
        resource_id = resources[index].id
        Favorite.create!(
          user_id: user.id,
          resource_id: resource_id
        )
      end
    end

    it "adds favorite_id to resources with favorites" do
      all_resources = Resource.all.with_favorites(user.id)
      favorites_count = all_resources.to_a.count do |resource|
        !resource.favorite_id.nil?
      end
      expect(favorites_count).to eq(3)
    end
  end

  describe "#normalize_friendly_id" do
    let(:resource_title) { 'Best JavaScript Site Ever!' }
    let(:resource) { build(:resource, title: resource_title) }
    let(:friendly_id) { resource_title.parameterize }

    it "parameterizes the title" do
      expect(resource.normalize_friendly_id(resource_title)).to eq(friendly_id)
    end

    it "appends a number if a resource with the title already exists" do
      create(:resource, title: resource_title)
      expect(resource.normalize_friendly_id(resource_title))
        .to eq("#{friendly_id}-1")
      create(:resource, title: resource_title)
      expect(resource.normalize_friendly_id(resource_title))
        .to eq("#{friendly_id}-2")
    end
  end

end
