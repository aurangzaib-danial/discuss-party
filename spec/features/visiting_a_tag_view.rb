require 'rails_helper'

RSpec.feature 'Visiting a tag view', type: 'feature' do
  include_examples 'scoped tests'
  include_examples 'listing topics'

  subject { create(:tag) }
  let(:topics) { subject.topics }

  def visit_subject
    visit tag_path(tag)
  end

  def visit_collection
    another_tag = build(:tag)
    2.times do
      create(:topic, topic_tags: [], tags: [subject, another_tag])
    end
    visit_subject
  end

  scenario 'shows no content message if no topic is available' do
    visit_subject
    message = "No topic available for #{subject.name}, be the first to create one."
    expect(page).to have_content(message)
  end

end
