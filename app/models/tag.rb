class Tag < ApplicationRecord
  has_many :topic_tags, dependent: :delete_all
  has_many :topics, through: :topic_tags

  validates_presence_of :name
  validates_length_of :name, minimum: 3, maximum: 30
  validates_uniqueness_of :name
  validates_format_of(:name, with: /[a-zA-Z0-9]/, 
    message: 'must have atleast a letter or a number')


  def self.find_by_slug(slug)
    find_by_name(slug) || 
    raise(ActiveRecord::RecordNotFound, 
      "Couldn't find Tag with 'slug'=#{slug}")
  end

  def slug
    name
  end

end
