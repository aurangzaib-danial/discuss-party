require 'rails_helper'

RSpec.describe 'Site', type: :request do
  describe 'root path' do
    it 'lists topics title, user and tags' do
      2.times { create(:topic) }
      @topic_1 = Topic.first
      @topic_2 = Topic.second

      get root_path
    
      expect_statments_for_topics
    end
  end
end
