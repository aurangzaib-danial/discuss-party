module CommentsHelper
  def comment_error(comment)
    'is-invalid' if comment.errors.any?
  end
end
