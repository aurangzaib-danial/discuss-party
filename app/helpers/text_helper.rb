module TextHelper
  def email_link(email)
    link_to email, "mailto:#{email}"
  end
end
