# == Schema Information
#
# Table name: notifications
#
#  id               :integer          not null, primary key
#  status           :string
#  readed           :boolean          default(FALSE)
#  content          :string
#  notificable_id   :integer
#  notificable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Notification < ApplicationRecord
  SUCCESSFUL_TYPE = 'successful'.freeze
  ERROR_TYPE      = 'error'.freeze

  belongs_to :notificable, polymorphic: true

  scope :unread, -> { where(readed: false) }

  def mark_as_readed
    update(readed: true) unless readed
  end
end
