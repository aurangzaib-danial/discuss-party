class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :recoverable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  has_many :topics
  has_many :comments

  slug_for :name

  validates_presence_of :name
  validates_format_of :name, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/
  validates_length_of :name, maximum: 50
  strip_attributes only: :name

  before_save :downcase_name

  def downcase_name
    name.downcase!
  end

end
