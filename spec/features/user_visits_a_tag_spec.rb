require 'rails_helper'

RSpec.feature 'User visits a tag', type: 'feature' do
  scenario 'latest topics are listed by created_at in descending order' do
    tag = create(:tag)
    topics = 2.times.collect { |n| create(:topic, title: "title#{n}", tags: [tag]) }
    visit tag_slug_path(tag.slug)
    topic_titles = page.all('h5.card-title').map { |result| result.text }
    expect(topic_titles).to eq([topics.second.title, topics.first.title])
  end
end
