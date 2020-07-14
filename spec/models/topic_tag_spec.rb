require 'rails_helper'

RSpec.describe TopicTag, type: :model do
  subject { create(:topic_tag) }
  it { should belong_to(:topic) }
  it { should belong_to(:tag).counter_cache('topics_count') }
  it { should have_db_index([:topic_id, :tag_id]).unique }
end
