class NotificationBuilder
  attr_reader :content, :status, :notification_content, :user

  def initialize(content: nil)
    raise NotImplementedError, 'Specify content' unless content
    @content = content
    find_user
  end

  def create
    user.notifications.create(notificable: content, status: status, content: notification_content)
  end

  def find_user
    if content.is_a?(Company)
      @user = content.user
    elsif content.is_a?(Page)
      @user = content.company.user
    end
  end

  def success(message)
    @status = Notification::SUCCESS_STATUS
    @notification_content = message
    self
  end

  def error(message)
    @status = Notification::ERROR_STATUS
    @notification_content = message
    self
  end
end
