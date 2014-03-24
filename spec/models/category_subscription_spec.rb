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
  pending "add some examples to (or delete) #{__FILE__}"
end
