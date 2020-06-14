require 'rails_helper'

RSpec.describe TagsHelper, type: :helper do
  it '#print tags concats, wrap each name with mark tag and marks the string html_safe' do
    tags = Tag.create!([{name: 'fiction'}, {name: 'fun'}])
    expect(helper.print_tags(tags)).to eq('<mark class="text-capitalize">fiction</mark>, <mark class="text-capitalize">fun</mark>')
    expect(helper.print_tags(tags)).to be_html_safe
  end
end
