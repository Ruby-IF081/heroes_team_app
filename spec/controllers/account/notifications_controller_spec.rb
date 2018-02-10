require 'rails_helper'

RSpec.describe Account::NotificationsController, type: :controller do
  context 'read notification' do
    let!(:notification) { create(:notification) }
    before :each do
      @user = notification.user
      sign_in @user
    end

    it 'should read notification' do
      get :read, xhr: true, params: { id: notification.id }
      notification.reload
      expect(notification.readed).to eq(true)
    end

    it 'responce should be success' do
      get :read, xhr: true, params: { id: notification.id }
      expect(response).to have_http_status(:success)
    end
  end

  context 'read all notifications' do
    let!(:notifications) { create_list(:notification, 30) }
    before :each do
      @user = notifications.first.user
      sign_in @user
    end

    it 'should read all notification' do
      get :read_all, xhr: true
      expect(@user.notifications.unread.count).to eq(0)
    end

    it 'responce should be success' do
      get :read_all, xhr: true
      expect(response).to have_http_status(:success)
    end
  end
end
