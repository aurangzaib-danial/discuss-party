class Tag < ApplicationRecord
  has_many :topic_tags
  has_many :topics, through: :topic_tags

  validates_presence_of :name
  validates_length_of :name, minimum: 3, maximum: 30
  validates_uniqueness_of :name

  before_validation :parameterize_name

  def parameterize_name
    self.name = name.parameterize if name
  end
end
