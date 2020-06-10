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
    it { should strip_attribute :title }
    it { should validate_length_of(:title).is_at_least(5).is_at_most(70)}
    
    describe 'title can only have letters, numbers and spaces' do
      it { should allow_value('The trees around us are our saviours 123').for(:title)}
      it { should_not allow_value('##This is a title!!! With bad characters!').for(:title)}
    end
    
    it { should validate_length_of(:description).is_at_least(20)}
  end 
end
