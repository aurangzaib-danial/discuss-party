module RequestHelper
  def expect_statements_for_topics
    expect(response.body).to include(@topic_1.title)
    expect(response.body).to include(@topic_1.user.name)
    expect(response.body).to include(@topic_1.tags.first.name)
    expect(response.body).to include(@topic_1.description.strip[0..100] + '...')

    expect(response.body).to include(@topic_2.title)
    expect(response.body).to include(@topic_2.user.name)
    expect(response.body).to include(@topic_2.tags.first.name)
    expect(response.body).to include(@topic_2.description.strip[0..100] + '...')
  end
end

RSpec.configure do |config|
  config.include RequestHelper, type: :request
end

