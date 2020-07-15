class Tag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged history]

  scope :alphabetically, -> { order('LOWER(name)') }

  has_many :topic_tags, dependent: :delete_all
  has_many :topics, through: :topic_tags

  validates_presence_of :name
  validates_length_of :name, minimum: 3, maximum: 30
  validates_uniqueness_of :name
  validates_format_of(:name, with: /[a-zA-Z0-9]/, 
    message: 'must have at least a letter or a number')

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
