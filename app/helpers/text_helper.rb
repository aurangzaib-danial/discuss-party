module TextHelper
  def email_link(email)
    link_to email, "mailto:#{email}"
  end

  def first_topic?(counter)
    ' first_topic' if counter == 0
  end

  def heading_id
    @topics.present? ? 'topHeading' : 'simpleHeading'
  end

  def read_time(topic)
    pluralize(topic.reading_time, 'minute') + ' read'
  end
end
