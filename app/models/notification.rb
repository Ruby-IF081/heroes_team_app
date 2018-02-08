# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  status     :string
#  readed     :boolean          default(FALSE)
#  content    :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notification < ApplicationRecord
  SUCCESS_TYPE = 'successful'.freeze
  ERROR_TYPE   = 'error'.freeze

  belongs_to :user
  belongs_to :notificable, polymorphic: true

  scope :unread, -> { where(readed: false) }

  validates :status,  presence: true
  validates :content, presence: true

  def mark_as_readed
    update(readed: true) unless readed
  end
end
