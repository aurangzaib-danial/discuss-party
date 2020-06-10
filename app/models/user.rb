class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  has_many :topics
  validates_presence_of :name
  validates_format_of :name, without: /[^A-Za-z\s]/
  validates_length_of :name, maximum: 50
  strip_attributes only: :name

  before_save :downcase_name

  def downcase_name
    name.downcase!
  end
end
