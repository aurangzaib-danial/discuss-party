require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:topics).with_foreign_key(:creator_id).dependent(:delete_all).inverse_of(:creator)}
    it { should have_many(:comments).dependent(:delete_all) }
    it { should have_many(:topic_votes).dependent(:delete_all) }
    it { should have_many(:voted_topics).through(:topic_votes).source(:topic) }
    it { should have_many(:viewers).dependent(:delete_all) }
    it { should have_many(:shared_topics).through(:viewers).source(:topic) }
    it { should have_many(:oauth_identities).dependent(:delete_all)}
  end
  it { should have_db_column :name }
  it { should have_db_column(:role).of_type(:integer)}
  it { should have_db_index(:role)}

  it do 
    should define_enum_for(:role).
    with_values(normal_user: 0, admin: 1, moderator: 2)
  end

  it {should have_db_column(:status).of_type(:integer)}
  it {should have_db_index(:status)}

  it do 
    should define_enum_for(:status).
    with_values(active: 0, blocked: 1)
  end

  it { should validate_presence_of :name }
  it { should_not allow_value('Sunny123#$').for(:name) }
  it { should validate_length_of(:name).is_at_most(50)}
  it { should strip_attribute(:name).collapse_spaces }
  it "downcases name before saving" do
    user = build(:user)
    user.name = 'Sunny'
    user.save
    expect(user.name).to eq('sunny')
  end

  describe '#slug' do
    it "should return the slugified version of user's name" do
      user = build(:user)
      user.name = "Sunny Khan"
      expect(user.slug).to eq('sunny-khan')
    end
  end

  it '#private_topics' do
    user = create(:user)
    topics = 2.times.collect { create(:topic, creator: user, visibility: :private) }
    expect(user.private_topics).to eq(topics)
  end

  describe '.make_mod_by_email' do
    def error(email)
      User.make_mod_by_email(email).errors[:moderator].first
    end
    
    it 'email does not exist' do
      expect(error('test@test.com')).to eq("Couldn't find user with that email")
    end

    it 'email of an admin' do
      user = create(:user, role: 'admin')
      expect(error(user.email)).to eq("Can't make an admin a moderator")
    end

    it 'email of a user who is already a moderator' do
      user = create(:user, role: 'moderator')
      expect(error(user.email)).to eq("This is user is already a moderator")
    end

    it 'user successful canditator for becoming a moderator' do
      user = create(:user)
      expect(User.make_mod_by_email(user.email)).to be_valid
    end
  end 

end
