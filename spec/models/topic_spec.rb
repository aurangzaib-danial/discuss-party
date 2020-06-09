require 'rails_helper'

RSpec.describe Topic, type: :model do
  it { should have_db_column(:title) }
  it { should have_db_column(:description) }
  it { should have_db_column(:status) }
  it { should belong_to(:user)}
  it { should have_many(:topic_tags) }
  it { should have_many(:tags).through(:topic_tags) }
end
