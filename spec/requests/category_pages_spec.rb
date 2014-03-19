require 'spec_helper'

describe "Category Pages" do
  subject { page }

  describe "Category View" do
    let(:category) { FactoryGirl.create(:category) }
    before { visit category_path(category) }

    it { should have_page_title(category.name) }

    context "with children" do
      before do
        5.times { FactoryGirl.create(:category, parent_id: category.id) }
        visit category_path(category)
      end

      it "should render all the category's children" do
        category.children.each do |child|
          should have_link(child.name, category_path(child))
        end
      end
    end

    context "with resources" do
      before do
        10.times { FactoryGirl.create(:resource, category_id: category.id) }
        visit category_path(category)
      end

      it "should render all the category's resources" do
        category.resources.each do |resource|
          should show_resource(resource)
        end
      end
    end

  end

end
