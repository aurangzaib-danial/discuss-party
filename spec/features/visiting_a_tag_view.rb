require 'rails_helper'

RSpec.feature 'Visiting a tag view', type: 'feature' do
  subject { create(:tag) }
  let(:topics) { subject.topics }

  def visit_tag
    visit tag_slug_path(subject.slug)
  end

  def visit_tag_with_topics
    another_tag = build(:tag)
    2.times do
      create(:topic, topic_tags: [], tags: [subject, another_tag])
    end
    visit_tag
  end

  scenario 'shows the tag name' do
    visit_tag
    expect(page).to have_content(subject.name)
  end

  scenario 'shows no content message if no topic is available' do
    visit_tag
    message = "No topic available for #{subject.name.capitalize}, be the first to create one."
    expect(page).to have_content(message)
  end

  scenario 'lists topics of the tag only' do
    unreleated_topic = create(:topic)
    visit_tag_with_topics
    run_expectations_for_topics(topics)
    expect(page).not_to have_content(unreleated_topic.title)
  end

  scenario 'lists latest topics by default' do
    visit_tag_with_topics
    expect(get_topic_titles).to eq([topics.second.title, topics.first.title])
  end

  scenario 'clicking oldest, lists topics by oldest' do
    visit_tag_with_topics
    click_link :oldest
    expect(current_path).to have_content(subject.name)
    expect(get_topic_titles).to eq([topics.first.title, topics.second.title])
  end

  scenario 'clicking popular, lists topics by popularity' do
    visit_tag_with_topics

    topics << create(:topic)
    topics.each.with_index(1) do |topic, index|
      topic.vote(topic.user, :like) if index == 2 || index == 3
      topic.vote(create(:user), :like) if index == 2
    end

    click_link :popular
    expect(get_topic_titles).to eq([topics.second.title, topics.third.title, topics.first.title])
  end

end
