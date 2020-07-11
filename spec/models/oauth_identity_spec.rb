require 'rails_helper'

RSpec.describe OauthIdentity, type: :model do
  it {should have_db_column(:uid).of_type(:integer)}
  it {should have_db_column(:provider).of_type(:string)}
  it {should belong_to(:user)}
  it {should have_db_index([:user_id, :provider]).unique}
  it do
    subject.user = create(:user)
    subject.save
    should validate_uniqueness_of(:user_id).scoped_to(:provider)
  end
end
