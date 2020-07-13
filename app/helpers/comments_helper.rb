module CommentsHelper
  def comment_error(comment)
    'invalid-comment' if comment.errors.any?
  end
end
