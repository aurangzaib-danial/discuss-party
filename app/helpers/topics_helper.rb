module TopicsHelper
  def print_tags(tags)
    tags.map do |tag|
      content_tag :mark, tag.name.capitalize
    end.join(', ').html_safe
  end
end
