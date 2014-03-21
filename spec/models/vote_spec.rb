# == Schema Information
#
# Table name: votes
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  resource_id :integer          not null
#  direction   :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Vote do
  pending "add some examples to (or delete) #{__FILE__}"
end
