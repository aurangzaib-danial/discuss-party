require 'rails_helper'

RSpec.feature 'Visiting a topic', type: :feature do
  let(:topic) { create(:topic) }
  scenario 'creator sees an edit link' do
    sign_in(topic.creator)
    visit topic_slug_path(topic.id, topic.slug)
    expect(page).to have_link('Edit')
  end

  scenario 'visitor cannot see an edit link' do
    sign_in(create(:user))
    visit topic_slug_path(topic.id, topic.slug)
    expect(page).to_not have_link('Edit')
  end

  context 'private topic' do
    scenario 'private is mentioned on a private topic' do
      topic = create(:topic, visibility: :private)
      visit topic_slug_path(topic.id, topic.slug)
      expect(page.find('main')).to have_content('Private')
    end

    scenario 'private is not mentioned on a public topic' do
      visit topic_slug_path(topic.id, topic.slug)
      expect(page.find('main')).to_not have_content('Private')
    end
  end
end
