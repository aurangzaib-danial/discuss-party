require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  it '#no_content_message returns html with message' do
    message = 'There is no content here!'
    expect(helper.no_content_message(message)).to include(message)
  end
end
