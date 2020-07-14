require 'rails_helper'

RSpec.feature 'User comments on a topic', type: :feature do
  let(:user) { create(:user)}
  let(:topic) { create(:topic)}

  before do
    sign_in user
    visit topic_slug_path(topic.id, topic.slug)
  end

  scenario 'visits a topic and creates a comment' do

    page.find('#comment_content_trix_input_comment', visible: false).set('This is a comment')
    click_button('Comment')

    expect(page).to have_content(user.name)
    expect(page).to have_content('This is a comment')
  end


  scenario 'comments are listed by latest' do
    topic.comments.create(user: user, content: 'One')
    topic.comments.create(user: user, content: 'Two')

    visit topic_slug_path(topic.id, topic.slug)
    comments = page.all('.comment-content .trix-content').map { |result| result.text }

    expect(comments).to eq %w(Two One)
  end
end
