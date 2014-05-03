# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  content     :text
#  resource_id :integer          not null
#  user_id     :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Comment do
  describe "validations" do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:resource) }
  end

  describe "associations" do
    it { should belong_to(:resource) }
    it { should belong_to(:user) }
  end
end
