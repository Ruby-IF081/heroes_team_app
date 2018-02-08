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

require 'rails_helper'

RSpec.describe Notification, type: :notification do
  let!(:notification) { create(:notification) }

  context 'validation' do
    it { FactoryBot.build(:notification).should be_valid }
  end

  it 'notification should be readed' do
    notification.mark_as_readed

    expect(notification.readed).to eq(true)
  end
end
