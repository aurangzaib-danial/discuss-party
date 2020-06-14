module TopicsHelper
  def short_description(topic)
    topic.description[0..19] + '...'
  end

  def topic_user_name(topic)
    content_tag :mark, topic.user.name, class: 'text-capitalize'
  end

  def topic_information(topic)
    "Created by #{topic_user_name(topic)} | Tags: #{print_tags(topic.tags)}".html_safe
  end
end
