require 'rails_helper'

RSpec.describe 'Site', type: :request do
  describe 'root path' do
    it 'lists topics title, user and tags' do
      2.times { create(:topic) }
      topic_1 = Topic.first
      topic_2 = Topic.second

      get root_path
      
      expect(response.body).to include(topic_1.title)
      expect(response.body).to include(topic_1.user.name)
      expect(response.body).to include(topic_1.tags.first.name)
      expect(response.body).to include(topic_1.description[0..19] + '...')

      expect(response.body).to include(topic_2.title)
      expect(response.body).to include(topic_2.user.name)
      expect(response.body).to include(topic_2.tags.first.name)
      expect(response.body).to include(topic_2.description[0..19] + '...')

    end
  end
end
