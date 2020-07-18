class Tag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged history]

  scope :alphabetically, -> { order by_downcase_name }

  has_many :topic_tags, dependent: :delete_all
  has_many :topics, through: :topic_tags

  validates_presence_of :name
  validates_length_of :name, minimum: 3, maximum: 30
  validates_uniqueness_of :name
  validates_format_of(:name, with: /[a-zA-Z0-9]/, 
    message: 'must have at least a letter or a number')
  validates :text_color, css_hex_color: true
  validates :background_color, css_hex_color: true

  after_commit :flush_cache

  class << self
    def by_downcase_name
      arel_table[:name].lower
    end

    def alphabetically_cached
      Rails.cache.fetch('tags_alphabetically') { Tag.alphabetically.load }
    end
  end

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  private
  def flush_cache
    Rails.cache.delete('tags_alphabetically')
  end
end
