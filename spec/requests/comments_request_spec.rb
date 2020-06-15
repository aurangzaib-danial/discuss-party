require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe 'POST /topics/:id/comments' do
    it 'cannot launch a post request if not signed in' do
      topic = create(:topic)
      post topic_comments_path(topic), params: { comment: { content: 'One'} }
      expect(response).to be_redirect
    end
  end
end 
