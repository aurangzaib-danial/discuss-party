require 'rails_helper'

RSpec.feature 'Visiting a user profile', type: 'feature' do
  subject(:user) {create(:user)}
  let(:topics) { subject.topics }

  def visit_profile
    visit user_slug_path(subject.id, subject.slug)
  end

  def profile_with_topics
    2.times { create(:topic, user: subject) }
    visit_profile
  end

  scenario 'visiting a user profile, shows user name' do
    visit_profile
    expect(page).to have_content(subject.name)
  end

  scenario 'shows no content message if no topic is available' do
    visit_profile
    message = "#{subject.name.titlecase} has not created a topic yet."
    expect(page).to have_content(message)
  end

end
