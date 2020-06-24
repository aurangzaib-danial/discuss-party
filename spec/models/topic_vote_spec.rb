require 'rails_helper'

RSpec.describe TopicVote, type: :model do
  subject { create(:topic_vote) }
  it { should have_db_column(:vote) }
  it { should belong_to(:topic) }
  it { should belong_to(:user) }
  it { should have_db_index([:topic_id, :user_id]).unique }
  it { should validate_presence_of(:vote) }
  it do
    expect(subject).to define_enum_for(:vote).
      with_values(like: 0, dislike: 1)
  end
  it { should validate_uniqueness_of(:topic_id).scoped_to(:user_id) }
end
