require 'rails_helper'

RSpec.describe Topic, type: :model do
  it { should have_db_column(:title) }
  it { should have_db_column(:description) }
  it { should have_db_column(:visibility) }
  it { should belong_to(:user)}
  it { should have_many(:topic_tags) }
  it { should have_many(:tags).through(:topic_tags) }
  it do 
    should define_enum_for(:visibility).
      with_values(public: 0, private: 1).
      with_prefix(:visibility)
  end
end
