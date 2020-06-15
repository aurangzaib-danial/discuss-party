require 'rails_helper'

RSpec.describe 'Tags', type: :request do
  let(:tag) { tag = create(:tag) }

  it 'shows tag name' do
    get tag_slug_path(tag.slug)
    expect(response.body).to include(tag.name)
  end

  it 'lists all the topics' do
    @topic_1 = build(:topic, topic_tags: [])
    @topic_1.topic_tags.build(tag: tag)
    @topic_1.save

    @topic_2 = build(:topic, topic_tags: [])
    @topic_2.topic_tags.build(tag: tag)
    @topic_2.save
    
    get tag_slug_path(tag.slug)

    expect_statements_for_topics

  end

  it 'shows no content message if no topic available for the tag' do
    get tag_slug_path(tag.slug)
    message = 'No topic available for this tag, be the first to create one.'
    expect(response.body).to include(message)
  end
end
