require 'rails_helper'

RSpec.feature 'Visiting a user profile', type: 'feature' do
  let(:user) {create(:user)}

  scenario 'visiting a user profile, shows user name' do
    visit user_slug_path(user.id, user.slug)
    expect(page.body).to have_content(user.name)
  end
 
end
