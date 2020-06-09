require 'rails_helper'

RSpec.describe TopicTag, type: :model do
  it { should belong_to(:topic) }
  it { should belong_to(:tag) }
  it { should have_db_index([:topic_id, :tag_id]) }
end
