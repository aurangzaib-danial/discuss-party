require 'rails_helper'

RSpec.feature 'User visits their private topics', type: :feature do

  subject(:user) { create(:user) }
  let(:topics) { subject.private_topics }

  def visit_subject
    sign_in user
    visit private_path
  end

  def visit_collection
    2.times { create(:topic, creator: user, visibility: :private) }
    visit_subject
  end

  scenario 'lists private topics of current user' do
    public_topic = create(:topic, creator: user)
    unreleated_topic = create(:topic)
    visit_collection

    run_expectations_for_topics(topics)
    expect(page).to_not have_content(public_topic.title)
    expect(page).to_not have_content(unreleated_topic.title)
  end

  scenario 'shows message when no private topic is available' do
    sign_in user
    visit private_path
    expect(page).to have_content('You do not have any private topic.')
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

    create(:topic, creator: user, visibility: :private)
    topics.each.with_index(1) do |topic, index|
      topic.vote(topic.creator, :like) if index == 2 || index == 3
      topic.vote(create(:user), :like) if index == 2
    end

    click_link :popular
    expect(get_topic_titles).to eq([topics.second.title, topics.third.title, topics.first.title])
  end


end
