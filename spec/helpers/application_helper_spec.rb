require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  it '#no_content_message returns html with message' do
    message = 'There is no content here!'
    html = <<-HTML
      <p class="lead">There is no content here!</p>
    HTML

    expect(helper.no_content_message(message)).to eq(html.strip)
  end
end
