# == Schema Information
#
# Table name: notifications
#
#  id               :integer          not null, primary key
#  status           :string
#  readed           :boolean          default(FALSE)
#  content          :string
#  user_id          :integer
#  notificable_id   :integer
#  notificable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Notification < ApplicationRecord
  SUCCESS_STATUS        = 'successful'.freeze
  ERROR_STATUS          = 'error'.freeze
  NOTIFICATION_STATUSES = [SUCCESS_STATUS, ERROR_STATUS].freeze

  belongs_to :user
  belongs_to :notificable, polymorphic: true

  scope :unread, -> { where(readed: false).order(created_at: :desc) }

  validates :status,  presence: true
  validates :content, presence: true

  def mark_as_readed
    update(readed: true) unless readed
  end
end
