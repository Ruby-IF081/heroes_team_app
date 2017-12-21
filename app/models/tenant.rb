class Tenant < ApplicationRecord
  VALID_WEBSITE_REGEX = /\A(www.)?[^_\W][-a-zA-Z0-9_]+\.+[-a-zA-Z0-9]+\z/i
  VALID_PHONE_REGEX = /\A[+]?[\d\-.() ]+\z/

  has_many :users
  has_many :companies, through: :subscriptions

  validates :name, presence: true, length:    { minimum: 3, maximum: 64 }
  validates :website, presence: true, length: { minimum: 3, maximum: 64 },
                      format:                 { with: VALID_WEBSITE_REGEX },
                      uniqueness:             { scope: :name, case_sensitive: false }
  validates :phone, length: { maximum: 32 }, format: { with: VALID_PHONE_REGEX }
end
