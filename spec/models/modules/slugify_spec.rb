require 'rails_helper'

class DummyClass
  attr_accessor :title
  extend Slugify

end

RSpec.describe Slugify do
  it '#slug_for takes an attribute and defines a slug method based on it' do
    DummyClass.slug_for(:title)

    dc = DummyClass.new
    dc.title = 'This is a title'

    expect(dc.slug).to eq('this-is-a-title')
  end
end
