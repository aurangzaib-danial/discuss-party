require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many :topics }
  end
  it { should have_db_column :name }
  it { should validate_presence_of :name }
  it { should_not allow_value('Sunny123#$').for(:name) }
  it { should validate_length_of(:name).is_at_most(50)}
  it { should strip_attribute(:name) }
  it "downcases name before saving" do
    user = build(:user)
    user.name = 'Sunny'
    user.save
    expect(user.name).to eq('sunny')
  end
end
