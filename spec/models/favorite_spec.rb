# == Schema Information
#
# Table name: favorites
#
#  id          :integer          not null, primary key
#  resource_id :integer          not null
#  user_id     :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Favorite do
  pending "add some examples to (or delete) #{__FILE__}"
end
