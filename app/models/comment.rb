class Comment < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  
  has_rich_text :content

  validates_presence_of :content

  scope :with_users, -> { includes(user: {display_picture_attachment: :blob}) }

  def commentator?(user)
    self.user_id == user.id
  end

  def topic_creator?(user)
    topic.creator_id == user.id
  end

end
