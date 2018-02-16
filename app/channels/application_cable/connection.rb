module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include SessionsHelper

    identified_by :user

    def connect
      self.user = find_verified_user
    end

    private

    def find_verified_user
      if current_user
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
