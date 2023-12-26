class Story < ApplicationRecord
  acts_as_paranoid #軟刪除套件

  extend FriendlyId
  friendly_id :slug_candidate, use: :slugged

  include AASM
  aasm(column: 'status',no_direct_assignment: true) do
    state :draft, initial: 'true'
    state :published

    event :publish do
      transitions from: :draft, to: :published
    end

    event :unpublish do
      transitions from: :published, to: :draft
    end
  end

  # relationships
  belongs_to :user
  has_one_attached :cover_image
  has_many :comments
  has_many :likes, dependent: :destroy

  # validations
  validates :title, presence: true

  # scopes
  # default_scope{ where(deleted_at: nil)} # 軟刪除手刻
  # scope :published_story, -> {where(status: 'published')}

  # methods
  # def destroy
  #   update(deleted_at: Time.now)
  # end #軟刪除手刻
  # def find_like(user)
  #   self.likes.where( :user_id => user.id ).first
  # end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  private
  def slug_candidate
    [
      :title,
      [:title, SecureRandom.hex[0,6]]
    ]
  end
end
