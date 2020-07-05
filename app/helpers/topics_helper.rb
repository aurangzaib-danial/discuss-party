module TopicsHelper

  def back_path_for_topic(topic)
    if topic.persisted?
      unless topic.title.present?
        topic.title = topic.title_change.first
      end
      topic_slug_path(topic.id, topic.slug)
    else
      root_path
    end
  end

  def topic_edit_link(topic)
    topic_hidden_link_test(topic, :edit, 'Edit')
  end

  def topic_sharing_link(topic)
    topic_hidden_link_test(topic, :sharing, 'Manage Sharing') if topic.visibility_private?
  end

  def topic_hidden_link_test(topic, action, text)
    if policy(topic).send("#{action}?")
      result = ' | '
      result << link_to(text, send("#{action}_topic_path", topic.id, topic.slug), class: 'special-link')
      result.html_safe
    end
  end

  def private_topic?(topic)
    if topic.visibility_private?
      content_tag :span, 'Private', class: 'badge badge-dark'
    end
  end

  def short_description(topic)
    topic.description[0..100].strip + '...'
  end

  def topic_user_name(topic)
    content_tag :mark, class: 'text-capitalize' do
      link_to topic.creator.name, user_slug_path(topic.creator.id, topic.creator.slug)
    end
  end

  def topic_information(topic)
    <<-HTML.html_safe
    Created by #{topic_user_name(topic) } #{topic_created_at_in_words(topic)}
    | Tags: #{print_tags(topic.tags)}
    HTML
  end

  def topic_created_at_in_words(topic)
    distance_of_time_in_words_to_now(topic.created_at) + ' ago'
  end

  def vote_button(topic, user, type)
    button_tag type: 'submit', id: type, class: vote_button_class(topic_marked?(topic, user, type)) do
      vote_icon(type, topic_marked?(topic, user, type)) + ' ' + vote_count(topic, type)
    end
  end

  def vote_icon(type, marked)
    mark_class = marked ? 'fas' : 'far'

    content_tag :i, nil,
      class: "#{mark_class} fa-thumbs-up #{icon_rotate_class(type)}"
  end

  def vote_form(topic, current_user, vote_type)
    form_with url: vote_topic_path(topic), method: :patch, local: true do |form|
      (form.hidden_field :vote, value: vote_type) <<
      (vote_button topic, current_user, vote_type)
    end
  end

  private
  def vote_button_class(marked)
    "btn #{'thumb-marked' if marked}"
  end

  def icon_rotate_class(type)
    'fa-rotate-180' if type == :dislike
  end

  def topic_marked?(topic, user, type)
    topic.send("#{type}d_by?", user)
  end

  def vote_count(topic, type)
    topic.send("#{type}s").to_s
  end
end
