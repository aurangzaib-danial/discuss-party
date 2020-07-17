require 'rails_helper'

RSpec.feature 'Reporting a topic', type: :feature do
  it 'topic reported by user is not available in their feed' do
    topic = create(:topic)
    user = create(:user)
    sign_in user
    topic.reports.create(user: user, report_type: 'rude')
    visit root_path
    expect(page).to_not have_content(topic.title)
  end
end
