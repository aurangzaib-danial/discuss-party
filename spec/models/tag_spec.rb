require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { should have_db_column(:name) }
  it { should have_many(:topic_tags).dependent(:delete_all) }
  it { should have_many(:topics).through(:topic_tags) }
  it { should have_db_column(:topics_count).of_type(:integer).with_options(default: 0, null: false) }
  it { should have_db_column(:text_color).with_options(default: '#FFFFFF', null: false) }
  it { should have_db_column(:background_color).with_options(default: '#17a2b8', null: false) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(30) }
    it 'name must have atleast a letter or a number' do
      should_not allow_value('$$$$$$$$').for(:name).with_message('must have at least a letter or a number')
      should allow_value('$$$$$$$$$a').for(:name)
      should allow_value('$$$$$$$$$1').for(:name)
    end
    it 'should validate_uniqueness_of name' do
      tag_1 = create(:tag)
      tag_2 = build(:tag, name: tag_1.name)
      expect(tag_2).to be_invalid
    end
    it { should have_db_index(:name).unique }
  end

end
