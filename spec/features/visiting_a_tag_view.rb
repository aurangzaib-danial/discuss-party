require 'rails_helper'

RSpec.feature 'Visiting a tag view', type: 'feature' do
  subject { create(:tag) }

  scenario 'shows the tag name' do
    visit tag_slug_path(subject.slug)
    expect(page).to have_content(subject.name)
  end

  scenario 'shows no content message if no topic is available' do
    visit tag_slug_path(subject.slug)
    message = "No topic available for #{subject.name.capitalize}, be the first to create one."
    expect(page).to have_content(message)
  end

  scenario 'lists all the available topics' do
    another_tag = build(:tag)
    topics = 2.times.collect do
      topic = create(:topic, topic_tags: [], tags: [subject, another_tag])
    end
    visit tag_slug_path(subject.slug)
    run_expectations_for_topics(topics)
  end
end
