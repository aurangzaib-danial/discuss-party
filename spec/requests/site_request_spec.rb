require 'rails_helper'

RSpec.describe 'Site', type: :request do
  describe 'root path' do
    it 'lists all the topics' do
      2.times { create(:topic) }
      get root_path
      expect(response.body).to include(Topic.first.title)
      expect(response.body).to include(Topic.second.title)
    end
  end
end
