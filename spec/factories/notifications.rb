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

FactoryBot.define do
  factory :notification do
    association :user, factory: :user
    association :notificable, factory: :page
    status { Notification::NOTIFICATION_STATUSES.sample }
    content { "Page was processed" }
  end
end
