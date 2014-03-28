# == Schema Information
#
# Table name: user_interactions
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  interactive_id   :integer
#  interactive_type :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

describe UserInteraction do
  pending "add some examples to (or delete) #{__FILE__}"
end
