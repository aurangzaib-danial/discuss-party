require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  it '#short_user_name returns short version of user\'s name for navbar and add three dots are the end' do
    user = build(:user)
    expect(helper.short_user_name(user).length).to eq(13)
    expect(helper.short_user_name(user)[-3..-1]).to eq('...')
  end
end
