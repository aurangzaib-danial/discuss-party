module TagsHelper
  def print_tags(tags)
    tags.map do |tag|
      content_tag :mark, tag.name, class: 'text-capitalize'
    end.join(', ').html_safe
  end
end
