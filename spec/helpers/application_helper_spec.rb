require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'no_content_message' do
    it 'return value includes the message passed' do
      message = 'There is no content here!'
      expect(helper.no_content_message(message)).to include(message)
    end
  end

  describe 'sort_link' do
    it 'takes a link name, includes the link name in the return value' do
      expect(helper.sort_link(:popular)).to include('popular')
    end

    it 'adds the sort type as query parameter' do
      expect(helper.sort_link(:popular)).to include('/?view=popular')
    end

    it 'does not add query parameter if the sort type is latest' do
      expect(helper.sort_link(:latest)).not_to include('/?view=latest')
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
