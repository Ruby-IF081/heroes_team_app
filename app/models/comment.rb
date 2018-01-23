class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  validates  :body, presence: true, length: { maximum: 300 }

  scope :reсent, -> { order(created_at: :desc) }
end
