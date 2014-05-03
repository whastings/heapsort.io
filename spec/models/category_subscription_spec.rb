# == Schema Information
#
# Table name: category_subscriptions
#
#  id            :integer          not null, primary key
#  subscriber_id :integer          not null
#  category_id   :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe CategorySubscription do
  describe "validations" do
    it { should validate_presence_of(:subscriber) }
    it { should validate_presence_of(:category) }
  end

  describe "associations" do
    it { should belong_to(:category) }
    it { should belong_to(:subscriber).class_name('User') }
    it { should have_many(:feed_items).through(:category) }
  end
end
