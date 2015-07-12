require 'spec_helper'

describe Relationship do
  let(:follower)     { FactoryGirl.create(:user) }
  let(:followed)     { FactoryGirl.create(:user) }
  let(:relationship) { follower.relationship.build(followed_id: followed.id) }

  subject { relationship }

  it { should be_valid }

  describe "followed methods" do
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }
    its(:follower) { should eq follower }
    its(:followed) { should eq followed  }
  end
end
