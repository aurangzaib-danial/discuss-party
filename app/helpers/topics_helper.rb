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

  def vote_button(type, marked)
    button_tag type: 'submit', id: type, class: vote_button_class(marked) do
      vote_icon(type, marked)
    end
  end

  def vote_icon(type, marked)
    mark_class = marked ? 'fas' : 'far'

    content_tag :i, nil,
      class: "#{mark_class} fa-thumbs-up #{icon_rotate_class(type)}"
  end

  def vote_form(topic, vote_type)
    form_with url: vote_topic_path(topic), method: :patch, local: true do |form|
      (form.hidden_field :vote, value: vote_type) <<
      (vote_button vote_type, topic.send("#{vote_type}d?", current_user))
    end
  end

  private
  def vote_button_class(marked)
    "btn #{'thumb-marked' if marked}"
  end

  def icon_rotate_class(type)
    'fa-rotate-180' if type == :dislike
  end
end
