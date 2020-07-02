require 'rails_helper'

RSpec.describe Viewer, type: :model do
  it { should belong_to(:topic) }
  it { should belong_to(:user) }
  it { should have_db_index([:topic_id, :user_id]).unique }
end
