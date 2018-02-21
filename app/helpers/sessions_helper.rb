module SessionsHelper
  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: cookies.signed['user.id'])
  end
end
