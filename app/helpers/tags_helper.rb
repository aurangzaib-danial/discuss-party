module TagsHelper
  def print_tags(tags)
    tags.map do |tag|
      link_to "##{tag.name}", tag_path(tag), class: 'text-secondary'
    end.join(' ')
  end

  def tag_pill(tag)
    link_to tag.name, tag_path(tag), class: 'tag-pill', style: tag_style(tag)
  end

  private
  def tag_style(tag)
    "color: #{tag.text_color}; background-color: #{tag.background_color}"
  end
end
