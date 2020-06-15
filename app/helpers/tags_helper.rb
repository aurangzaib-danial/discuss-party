module TagsHelper
  def print_tags(tags)
    tags.map do |tag|
      content_tag :mark, 
        link_to(tag.name, tag_slug_path(tag.slug), class: 'text-dark'), 
        class: 'text-capitalize'
    end.join(', ').html_safe
  end
end
