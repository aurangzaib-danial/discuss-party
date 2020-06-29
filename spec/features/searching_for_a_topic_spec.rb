require 'rails_helper'

RSpec.feature 'Searching for a topic', type: 'feature' do

  before do
    @topics = 2.times.collect do |n|
      create(:topic, title: "beautiful-#{n}") 
    end
  end

  def run_search
    visit search_path
    fill_in :big_search, with: 'beautiful'
    click_button :big_search_submit
  end
  
  scenario 'using the navbar search' do

    visit root_path
    fill_in :navbar_search, with: 'beautiful'
    click_button 'Search'

    expect(page).to have_content('Found 2 topics')
    run_expectations_for_topics(@topics)
  end

  scenario 'using the main search' do
    run_search
    run_expectations_for_topics(@topics)
  end

  scenario 'lists latest topics by default' do
    run_search
    expect(get_topic_titles).to eq([@topics.second.title, @topics.first.title])
  end

  scenario 'clicking oldest, lists topics by oldest' do
    run_search
    click_link :oldest
    expect(get_topic_titles).to eq([@topics.first.title, @topics.second.title])
  end

  scenario 'clicking popular, lists topics by popularity' do
    run_search
    @topics << create(:topic, title: 'beautiful-3')
    @topics.each.with_index(1) do |topic, index|
      topic.vote(topic.user, :like) if index == 2 || index == 3
      topic.vote(create(:user), :like) if index == 2
    end

    click_link :popular
    expect(get_topic_titles).to eq([@topics.second.title, @topics.third.title, @topics.first.title])
  end

end
