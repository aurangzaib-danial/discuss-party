require 'rails_helper'

RSpec.feature 'User votes on a topic', type: :feature do
  def visit_topic
    visit topic_slug_path(topic.id, topic.slug)
  end
  let(:topic) { create(:topic) }
  
  scenario 'guest cannot vote on a topic' do
    visit_topic
    click_button :like
    expect(page).to have_current_path(new_user_session_path)
  end

  scenario 'user likes a topic' do
    sign_in(create(:user))
    visit_topic
    click_button :like
    expect(page).to have_content(topic.title)
    expect(page).to have_css('#like.thumb-marked')
  end
  
end
