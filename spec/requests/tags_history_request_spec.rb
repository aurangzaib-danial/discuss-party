require 'rails_helper'

RSpec.describe "Topics", type: :request do
  let(:tag) {create(:tag, name: 'reading')}

  it 'renaming a tag, its old route and new route both work' do
    tag.update(name: 'reading-books')

    get tag_path('reading')
    expect(response).to be_successful

    get tag_path('reading-books')
    expect(response).to be_successful
  end
end
