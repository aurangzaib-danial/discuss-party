module TextHelper
  def email_link(email)
    link_to email, "mailto:#{email}"
  end

  def first_topic?(counter)
    ' first_topic' if counter == 0
  end
end
