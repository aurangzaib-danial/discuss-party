require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'no_content_message' do
    it 'return value includes the message passed' do
      message = 'There is no content here!'
      expect(helper.no_content_message(message)).to include(message)
    end
  end

  describe 'sort_link_path' do

    it 'creates a link for the request path itself' do
      helper.request.path = '/'
      expect(helper.sort_link_path(:latest)).to eq('/')

      helper.request.path = '/non-fiction'
      expect(helper.sort_link_path(:latest)).to eq('/non-fiction')
    end

    it 'adds the sort type as query parameter' do
      expect(helper.sort_link_path(:popular)).to include('?view=popular')
    end

    it 'does not add query parameter if the sort type is latest' do
      expect(helper.sort_link_path(:latest)).not_to include('?view=latest')
    end

    it 'correctly returns the full path with query string' do
      helper.request.path = '/'
      expect(helper.sort_link_path(:popular)).to eq('/?view=popular')
      
      helper.request.path = '/tag-2'
      expect(helper.sort_link_path(:oldest)).to eq('/tag-2?view=oldest')
      
      helper.request.path = '/users/aurangzaib-danial'
      expect(helper.sort_link_path(:latest)).to eq('/users/aurangzaib-danial')
    end
  end

  describe 'sort_link' do
    it 'takes a link name, includes the link name in the return value' do
      expect(helper.sort_link(:popular)).to include('popular')
    end

    it 'adds the sort type as query parameter' do
      expect(helper.sort_link(:popular)).to include('?view=popular')
    end

    it 'does not add query parameter if the sort type is latest' do
      expect(helper.sort_link(:latest)).not_to include('?view=latest')
    end

    it 'returns active class for link if the link is current' do
      helper.params[:view] = 'oldest'
      expect(helper.sort_link(:oldest)).to include('active')
    end

    it 'returns active class for latest without query parameter ' do
      expect(helper.sort_link(:latest)).to include('active')
    end

    it 'returns active class for latest with invalid value for query parameter ' do
      params[:view] = "bomb"
      expect(helper.sort_link(:latest)).to include('active')
    end

    it 'does not return active class for link if it is not current' do
      expect(helper.sort_link(:oldest)).not_to include('active')
    end
  end

end
