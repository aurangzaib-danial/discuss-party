require 'rails_helper'

RSpec.describe TopicVote, type: :model do
  it { should have_db_column(:vote) }
  it { should belong_to(:topic) }
  it { should belong_to(:user) }
  it { should have_db_index([:topic_id, :user_id]).unique }
  it do
    expect(subject).to define_enum_for(:vote).
      with_values(like: 0, dislike: 1)
  end
end
