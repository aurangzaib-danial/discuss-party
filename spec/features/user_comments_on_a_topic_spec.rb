require 'rails_helper'

RSpec.feature 'User comments on a topic', type: :feature do
  let(:user) { create(:user)}
  let(:topic) { create(:topic)}

  before do
    sign_in user
    visit topic_slug_path(topic.slug, topic.id)
  end

  scenario 'visits a topic and creates a comment' do

    fill_in :comment_content, with: 'This is a comment'
    click_button('Comment')

    expect(page).to have_content(user.name)
    expect(page).to have_content('This is a comment')
  end

  scenario 'error is shown on submitting empty comment' do
    click_button('Comment')
    expect(page).to have_css('.is-invalid')
  end

  scenario 'message is shown if no comments on a topic' do
    expect(page).to have_content('No one has commented yet. Be the first to start the discussion!')
  end

  scenario 'comment box is hidden when no user is logged in' do
    sign_out user
    visit topic_slug_path(topic.slug, topic.id)

    expect(page).not_to have_content('Comment as')
    expect(page).not_to have_field('#comment_content')
    expect(page).to have_content('Please sign in for joining the discussion.')
  end
end
