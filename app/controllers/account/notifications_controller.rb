class Account::NotificationsController < ApplicationController
  def index; end

  def read
    @notification = resource
    @notification.mark_as_readed
    @notifications_count = collection.unread.count
    render 'account/notifications/read'
  end

  private

  def collection
    Notification.all
  end

  def resource
    collection.find(params[:id])
  end
end
