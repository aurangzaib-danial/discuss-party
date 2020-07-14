require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { should have_db_column(:name) }
  it { should have_many(:topic_tags).dependent(:delete_all) }
  it { should have_many(:topics).through(:topic_tags) }
  it { should have_db_column(:topics_count).of_type(:integer).with_options(default: 0, null: false) }


  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(30) }
    it 'parameterize name before validation' do
      subject.name = 'tag-$hello'
      subject.save
      expect(subject.name).to eq('tag-hello')
    end
    it 'should validate_uniqueness_of name' do
      tag_1 = create(:tag)
      tag_2 = build(:tag, name: tag_1.name)
      expect(tag_2).to be_invalid
    end
    it { should have_db_index(:name).unique }
  end

  describe '.find_by_slug' do
    it 'can find a tag based on a slug' do
      tag = create(:tag)
      expect(Tag.find_by_slug(tag.slug)).to eq(tag)
    end

    it 'raises ActiveRecord::RecordNotFound error if tag is not found' do
      expect{Tag.find_by_slug('Fake tag')}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

end
