require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TopicsHelper. For example:
#
# describe TopicsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   ends
# end
RSpec.describe TopicsHelper, type: :helper do
  describe 'print tags' do
    it "concats, capitalizes the tag names and also wrap each name with mark tag" do
      tags = Tag.create!([{name: 'fiction'}, {name: 'fun'}])
      expect(helper.print_tags(tags)).to eq("<mark>Fiction</mark>, <mark>Fun</mark>")
    end
  end
end
