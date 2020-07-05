require 'rails_helper'

RSpec.feature 'Visiting topics shared with user', type: :feature do
  subject { create(:user) }
  let(:topics) { subject.shared_topics }

  def visit_subject
    sign_in subject
    visit shared_with_me_path
  end

  def visit_collection
    2.times do
      topic = create(:topic, visibility: :private)
      topic.viewers.create(user: subject)
    end
    visit_subject
  end

  scenario 'lists topics shared with user' do
    visit_collection
    run_expectations_for_topics(topics)
  end

  scenario 'shows message when no topic is shared with user' do
    visit_subject
    expect(page).to have_content('No one has shared a topic with you.')
  end

  scenario 'lists latest topics by default' do
    visit_collection
    expect(get_topic_titles).to eq([topics.second.title, topics.first.title])
  end

  scenario 'clicking oldest, lists topics by oldest' do
    visit_collection
    click_link :oldest
    expect(get_topic_titles).to eq([topics.first.title, topics.second.title])
  end

  scenario 'clicking popular, lists topics by popularity' do
    visit_collection

    topic = create(:topic, visibility: :private)
    topic.viewers.create(user: subject)
    
    topics.each.with_index(1) do |topic, index|
      topic.vote(topic.creator, :like) if index == 2 || index == 3
      topic.vote(create(:user), :like) if index == 2
    end

    click_link :popular
    expect(get_topic_titles).to eq([topics.second.title, topics.third.title, topics.first.title])
  end
end
