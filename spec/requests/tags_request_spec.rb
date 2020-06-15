require 'rails_helper'

RSpec.describe 'Tags', type: :request do
  let(:tag) { tag = create(:tag) }

  it 'shows tag name' do
    get tag_slug_path(tag.slug)
    expect(response.body).to include(tag.name)
  end

  it 'lists all the topics' do
    @topic_1 = build(:topic, tags: [])
    @topic_1.topic_tags.build(tag: tag)
    @topic_1.save

    @topic_2 = build(:topic, tags: [])
    @topic_2.topic_tags.build(tag: tag)
    @topic_2.save

    get tag_slug_path(tag.slug)

    expect_statements_for_topics

  end
end
