require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  describe '#short_user_name returns short version of user\'s name for navbar' do
    it 'returns only 10 characters of name if the length of name is greater than 10 and adds 3 dots at the end' do
      user = build(:user, name: 'Aurangzaib Danial')
      expect(helper.short_user_name(user).length).to eq(13)
      expect(helper.short_user_name(user)[-3..-1]).to eq('...')
    end

    it 'does not add three dots at the end of user\'s name length is less than or equal to 10 ' do
      user = build(:user, name: 'mark')
      expect(helper.short_user_name(user)[-3..-1]).not_to eq('...')
    end
  end
end
