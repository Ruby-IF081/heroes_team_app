# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  role                   :string           default("sale")
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  tenant_id              :integer
#  auth_token             :string
#  token_created_at       :datetime
#  birthday               :date
#  avatar                 :string
#  phone                  :string
#  skills                 :string
#  social_links           :string
#  education              :text
#  work                   :text
#  about                  :text
#  provider               :string
#  uid                    :string
#

class User < ApplicationRecord
  SALE_ROLE        = 'sale'.freeze
  ADMIN_ROLE       = 'admin'.freeze
  SUPER_ADMIN_ROLE = 'super_admin'.freeze
  ROLES            = [SALE_ROLE, ADMIN_ROLE, SUPER_ADMIN_ROLE].freeze
  DEFAULT_PASSWORD = 'password'.freeze

  has_many :comments,      dependent: :destroy
  has_many :companies,     dependent: :destroy
  has_many :visits,        dependent: :destroy
  has_many :notifications, dependent: :delete_all
  belongs_to :tenant, optional: true

  accepts_nested_attributes_for :tenant

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :tenant,     presence: true
  validates :role,       presence: true, inclusion: ROLES
  validates :phone, length: { maximum: 32 }, allow_blank: true, uniqueness: true
  validates :email, presence: true, uniqueness: true,
                    email_format: { message: 'has invalid format' }

  scope :by_date, -> { order(created_at: :asc) }

  delegate :name, to: :tenant, prefix: true, allow_nil: true

  mount_uploader :avatar, AvatarUploader

  def full_name
    [first_name, last_name].reject(&:blank?).join(' ')
  end

  def admin?
    role == User::ADMIN_ROLE
  end

  def super_admin?
    role == User::SUPER_ADMIN_ROLE
  end

  def privileged?
    admin? || super_admin?
  end

  def generate_auth_token
    token = SecureRandom.urlsafe_base64
    assign_attributes(auth_token: token, token_created_at: Time.zone.now)
  end

  def deactivate_token
    update(auth_token: nil, token_created_at: nil)
  end

  def authenticate_token_creation
    token_created_at.is_a?(ActiveSupport::TimeWithZone) && token_created_at >= 1.month.ago
  end

  comma do
    id
    full_name
    email
    role
    created_at { |created_at| created_at.strftime("%d %b %y %H:%M") }
  end

  def self.from_omniauth(auth)
    User.find_or_create_by(provider: auth.provider, uid: auth.uid)
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.facebook_data'])
        info = data['info']
        user.assign_attributes(email: info['email'], uid: data['uid'],
                               provider: data['provider'],
                               first_name: info['first_name'],
                               last_name: info['last_name'])
      end
    end
  end
end
