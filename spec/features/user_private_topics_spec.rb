require 'rails_helper'

RSpec.feature 'User visits their private topics' do
  let(:user) { create(:user) }
  let(:topics) do 
    2.times.collect do 
      create(:topic, visibility: :private, creator: user)
    end
  end

  scenario 'cannot visit private topics if not logged in' do
    visit private_path
    expect(current_path).to_not eq(private_path)
  end

  scenario 'only lists private topics of user' do
    topics
    public_topic = create(:topic, creator: user)
    sign_in user
    visit private_path

    run_expectations_for_topics(topics)
    expect(page).to_not have_content(public_topic.title)
  end

  scenario 'shows message when no private topic is available' do
    sign_in user
    visit private_path
    expect(page).to have_content('You do not have any private topic.')
  end


end
