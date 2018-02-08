class Account::NotificationsController < ApplicationController
  def index; end

  def read
    @notification = resource
    @notification.mark_as_readed
    @notifications_count = collection.unread.count
    render 'account/notifications/read'
  end

  def read_all
    collection.where(readed: false).update_all(readed: true)
    render 'account/notifications/read_all'
  end

  private

  def collection
    current_user.notifications.all
  end

  def resource
    collection.find(params[:id])
  end
end
