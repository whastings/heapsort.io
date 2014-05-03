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
  describe "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:resource_id) }
    it { should validate_presence_of(:direction) }

    it { should validate_uniqueness_of(:user_id).scoped_to(:resource_id) }

    it { should ensure_inclusion_of(:direction).in_array([1, 0]) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:resource) }
  end

  describe "::record_vote" do
    let(:user) { create(:user) }
    let(:resource) { create(:resource) }

    it "sets the vote's direction, user_id, and resource_id" do
      Vote.record_vote(resource.id, user.id, Vote::UP_VOTE)
      vote = Vote.last
      expect(vote.resource_id).to eq(resource.id)
      expect(vote.user_id).to eq(user.id)
      expect(vote.direction).to eq(Vote::UP_VOTE)
    end

    it "increments the resource's up vote count when up voting" do
      expect { Vote.record_vote(resource.id, user.id, Vote::UP_VOTE) }
        .to change { resource.reload.up_votes_count }.by(1)
    end

    it "increments the resource's down vote count when down voting" do
      expect { Vote.record_vote(resource.id, user.id, Vote::DOWN_VOTE) }
        .to change { resource.reload.down_votes_count }.by(1)
    end

    it "updates an existing vote" do
      existing_vote = resource.votes.create(
        user_id: user.id,
        direction: Vote::UP_VOTE
      )
      expect { Vote.record_vote(resource.id, user.id, Vote::DOWN_VOTE) }
        .to change { resource.reload.up_votes_count }.by(-1)
      expect(existing_vote.reload.direction).to eq(Vote::DOWN_VOTE)
    end

    it "prevents a user making the same vote twice" do
      expect do
        2.times do
          Vote.record_vote(resource.id, user.id, Vote::UP_VOTE)
        end
      end.to change { resource.reload.up_votes_count }.by(1)
    end
  end
end
