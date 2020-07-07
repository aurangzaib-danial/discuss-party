require 'rails_helper'

RSpec.feature 'Deleting a topic', type: :feature do
  let(:topic) { create(:topic) }
  before do
    sign_in topic.creator
  end

  it 'can successfully delete a topic' do
    visit edit_topic_path(topic.id, topic.slug)
    click_button 'Delete'
    expect{Topic.find(topic.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect(page).to have_content('Successfully deleted.')
  end
end
