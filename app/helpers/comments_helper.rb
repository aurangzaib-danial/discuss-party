module CommentsHelper
  def comment_error(comment)
    'is-invalid' if comment.errors.any?
  end

  def no_comment_message
    content_tag :p, 'No one has commented yet. Be the first to start the discussion!', class: 'lead'
  end
end
