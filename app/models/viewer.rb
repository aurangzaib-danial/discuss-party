class Viewer < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  
  attr_reader :user_email

  def user_email=(email)
    @user_email = email.try(:strip).try(:downcase)
  end

  before_validation :custom_validations_and_user_assignment_using_email

  def custom_validations_and_user_assignment_using_email
    return if user_email.nil? || topic_id.nil?

    if valid_email? && user_exists_by_email? && not_aleady_shared? && not_topic_creator
      self.user = @user_by_email
    end
  end

  def valid_email?
    user_email.email? ? true : report_error('Invalid email')
  end

  def user_exists_by_email?
    @user_by_email = User.find_by_email(user_email)
    @user_by_email ? true : report_error('Coud not find a user with that email')
  end

  def not_aleady_shared?
    if Viewer.exists?(topic: topic, user: @user_by_email)
      errors.add(:user_email, 'Already shared with this user')
    else
      true
    end
  end

  def not_topic_creator
    if topic.owner?(@user_by_email)
      report_error('You cannot share with yourself')
    else
      true
    end
  end

  def report_error(message)
    errors.add(:user_email, message)
    return false
  end
end
