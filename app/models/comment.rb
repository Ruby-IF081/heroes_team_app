class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  validates  :body, presence: true, length: { maximum: 400 }
  validates  :commentable, presence: true
  validates  :tenant_id, presence: true

  scope :recent, -> { order(created_at: :asc) }
end
