class NotificationBuilder
  attr_reader :content, :status, :notification_content, :user

  def initialize(content: nil, user: nil)
    raise ArgumentError('specify content') unless content
    @content = content
    find_user(user)
  end

  def create
    user.notifications.create(notificable: content, status: status, content: notification_content)
  end

  def find_user(user)
    if content.is_a?(Company)
      @user = content.user
    elsif content.is_a?(Page)
      @user = content.company.user
    elsif user.present?
      @user = user
    else
      raise ArgumentError('Specify user')
    end
  end

  def success(content)
    @status = Notification::SUCCESS_STATUS
    @notification_content = content
    self
  end

  def error(content)
    @status = Notification::ERROR_STATUS
    @notification_content = content
    self
  end
end
