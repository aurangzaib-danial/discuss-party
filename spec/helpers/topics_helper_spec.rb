require 'rails_helper'

RSpec.describe TopicsHelper, type: :helper do
  let(:topic) { create(:topic) }

  xit '#short description returns only 20 characters of description and adds three periods at the end' do
    expect(helper.short_description(topic)[-3..-1]).to eq("...")
    expect(helper.short_description(topic).length).to eq(23) # 3 chars of dots
  end

  it '#topic_user_name and marks the string html_safe' do
    expect(helper.topic_user_name(topic)).to eq("<mark class=\"text-capitalize\">#{topic.user.name}</mark>")
    expect(helper.topic_user_name(topic)).to be_html_safe
  end

  it '#topic_information returns topic user\'s name and tag names and marks the string html_safe' do
    
    expected_result = "Created by #{helper.topic_user_name(topic)} | Tags: #{helper.print_tags(topic.tags)}"
    
    expect(helper.topic_information(topic)).to eq(expected_result)
    expect(helper.topic_information(topic)).to be_html_safe
  end
end
