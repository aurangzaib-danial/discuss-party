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

  describe 'validations' do
    # title between 5 - 70
    # only numbers, letters and spaces in the middle, strip trailing spaces
    it { should strip_attribute :title }
  end 
end
