require 'rails_helper'

RSpec.feature 'Visiting the home view', type: 'feature' do
  def create_topics_and_visit
    @topics = 2.times.collect { create(:topic) }
    visit root_path
  end

  def get_topic_titles
    @topic_titles = page.all('h5.card-title').map { |result| result.text }
  end

  scenario 'shows no content message if no topic is available' do
    visit root_path
    message = 'No topic available, be the first to create one.'
    expect(page).to have_content(message)
  end

  scenario 'lists available topics' do
    create_topics_and_visit
    run_expectations_for_topics(@topics)
  end

  scenario 'lists latest topics by default' do
    create_topics_and_visit
    get_topic_titles
    expect(@topic_titles).to eq([@topics.second.title, @topics.first.title])
  end

  scenario 'clicking oldest, lists topics by oldest' do
    create_topics_and_visit
    click_link :oldest
    get_topic_titles
    expect(@topic_titles).to eq([@topics.first.title, @topics.second.title])
  end

  scenario 'clicking popular, lists topics by popularity' do
    create_topics_and_visit
    @topics << create(:topic)
    @topics.each.with_index(1) do |topic, index|
      topic.vote(topic.user, :like) if index == 2 || index == 3
      topic.vote(topic.user, :like) if index == 2
    end

    click_link :popular
    get_topic_titles
    expect(@topic_titles).to eq([@topics.second.title, @topics.third.title, @topics.first.title])
  end


end
