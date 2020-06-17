module TopicsHelper
  def short_description(topic)
    topic.description[0..100].strip + '...'
  end

  def topic_user_name(topic)
    content_tag :mark, class: 'text-capitalize' do
      link_to topic.user.name, user_slug_path(topic.user.id, topic.user.slug)
    end
  end

  def topic_information(topic)
    "Created by #{topic_user_name(topic) } #{topic_created_at_in_words(topic)}
    | Tags: #{print_tags(topic.tags)}".html_safe
  end

  def topic_created_at_in_words(topic)
    distance_of_time_in_words_to_now(topic.created_at) + ' ago'
  end
end
