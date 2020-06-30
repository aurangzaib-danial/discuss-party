require 'rails_helper'

RSpec.feature 'Visiting a user profile', type: 'feature' do
  include_examples 'scoped tests'
  include_examples 'listing topics'
  
  subject(:user) {create(:user)}
  let(:topics) { subject.topics }

  def visit_subject
    visit user_slug_path(subject.id, subject.slug)
  end

  def visit_collection
    2.times { create(:topic, user: subject) }
    visit_subject
  end

  scenario 'shows no content message if no topic is available' do
    visit_subject
    message = "#{subject.name.titlecase} has not created a topic yet."
    expect(page).to have_content(message)
  end

end
