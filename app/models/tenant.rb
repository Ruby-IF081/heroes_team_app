class Tenant < ApplicationRecord
  VALID_WEBSITE_REGEX = /\A[-a-z0-9_]+\.+[-a-z0-9\/]+\z/i

  has_many :users

  validates :name, presence: true, length: { minimum: 3, maximum: 64 }
  validates :website, presence: true, length: { minimum: 3, maximum: 64 },
	    format: { with: VALID_WEBSITE_REGEX },
	    uniqueness: { case_sensitive: false }
end
