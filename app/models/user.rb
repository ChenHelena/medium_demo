class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :stories
  validates :username, presence: true, uniqueness: true
  has_one_attached :avatar

  has_many :likes
  has_many :liked_stories, through: :likes, source: :story
end
