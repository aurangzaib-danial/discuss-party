require 'rails_helper'

RSpec.describe CommentsHelper, type: :helper do
  it '#comment_error returns .is_invalid css class if there is an error on a comment object' do
    comment = Comment.create
    expect(helper.comment_error(comment)).to eql('is-invalid')
  end
end
