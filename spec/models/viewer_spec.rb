require 'rails_helper'

RSpec.describe Viewer, type: :model do
  it { should belong_to(:topic) }
  it { should belong_to(:user) }
  it { should have_db_index([:topic_id, :user_id]).unique }
  it do
    user = create(:user)
    topic = create(:topic)
    viewer = create(:viewer, topic: topic, user: user)
    expect(viewer).to(validate_uniqueness_of(:topic_id)
      .scoped_to(:user_id)
      .with_message('already shared with this user.'))
  end
end
