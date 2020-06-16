require 'rails_helper'

RSpec.describe 'Site', type: :request do
  describe 'root path' do
    it 'lists topics title, user and tags' do
      2.times { create(:topic) }
      @topic_1 = Topic.first
      @topic_2 = Topic.second

      get root_path
    
      expect_statements_for_topics
    end

    it 'shows no content message if no topic is available' do
      message = 'No topic available, be the first to create one.'
      get root_path
      expect(response.body).to include(message)
    end

  end
end
