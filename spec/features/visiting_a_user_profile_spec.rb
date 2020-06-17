require 'rails_helper'

RSpec.feature 'Visiting a user profile', type: 'feature' do
  let(:user) {create(:user)}

  scenario 'visiting a user profile, show user name' do
    visit user_slug_path(user.id, user.slug)
    expect(page.body).to have_content(user.name)
  end
  scenario 'latest topics are listed by created_at in descending order' do
    topics = 2.times.collect { |n| create(:topic, title: "title#{n}", user: user) }
    visit user_slug_path(user.id, user.slug)
    topic_titles = page.all('h5.card-title').map { |result| result.text }
    expect(topic_titles).to eq([topics.second.title, topics.first.title])
  end
end
