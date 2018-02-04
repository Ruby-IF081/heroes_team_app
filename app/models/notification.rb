# == Schema Information
#
# Table name: notifications
#
#  id               :integer          not null, primary key
#  type             :string
#  content          :string
#  notificable_id   :integer
#  notificable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Notification < ApplicationRecord
  belongs_to :notificable, polymorphic: true
end
