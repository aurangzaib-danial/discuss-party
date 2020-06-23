module TopicsTestHelpers
  def expectations_for_topic(topic)
    expect(page).to have_content(topic.title)
    expect(page).to have_content(topic.user.name)
    expect(page).to have_content(topic.tags.first.name)
    expect(page).to have_content(topic.tags.second.name)
    expect(page).to have_content(helper.short_description(topic))
  end

  def run_expectations_for_topics(topics)
    topics.each {|topic| expectations_for_topic(topic) }
  end
end

RSpec.configure do |config|
  config.include RSpec::Rails::HelperExampleGroup, type: :feature
  config.include TopicsTestHelpers, type: :feature
end
