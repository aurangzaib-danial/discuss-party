require 'rails_helper'

RSpec.feature 'Visiting a user profile', type: 'feature' do
  subject(:user) {create(:user)}
  let(:topics) { subject.topics }

  def visit_profile
    visit user_slug_path(subject.id, subject.slug)
  end

  def visit_profile_with_topics
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

  scenario 'lists topics of the user only' do
    unreleated_topic = create(:topic)
    visit_profile_with_topics

    run_expectations_for_topics(topics)
    expect(page).not_to have_content(unreleated_topic.title)
  end

  scenario 'lists latest topics by default' do
    visit_profile_with_topics
    expect(get_topic_titles).to eq([topics.second.title, topics.first.title])
  end

  scenario 'clicking oldest, lists topics by oldest' do
    visit_profile_with_topics
    click_link :oldest
    expect(current_path).to have_content(subject.name.parameterize)
    expect(get_topic_titles).to eq([topics.first.title, topics.second.title])
  end

  scenario 'clicking popular, lists topics by popularity' do
    visit_profile_with_topics

    topics << create(:topic)
    topics.each.with_index(1) do |topic, index|
      topic.vote(topic.user, :like) if index == 2 || index == 3
      topic.vote(create(:user), :like) if index == 2
    end

    click_link :popular
    expect(get_topic_titles).to eq([topics.second.title, topics.third.title, topics.first.title])
  end

end
