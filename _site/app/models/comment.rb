class Comment < ApplicationRecord
  acts_as_paranoid #軟刪除套件

  belongs_to :user
  belongs_to :story

  validates :content, presence: true
end
