class Account::NotificationsController < ApplicationController
  def read
    @notification = resource
    @notification.mark_as_readed
    @notifications_count = collection.unread.count
  end

  def read_all
    collection.where(readed: false).update_all(readed: true)
  end

  private

  def collection
    current_user.notifications.all
  end

  def resource
    collection.find(params[:id])
  end
end
