# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  access_token           :string
#  admin                  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  expires_at             :integer
#  first_name             :string
#  last_name              :string
#  moderator              :boolean
#  provider               :string
#  refresh_token          :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  roles                  :jsonb            not null
#  uid                    :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_roles                 (roles) USING gin
#
class User < ApplicationRecord
  rolify
  include SimpleDiscussion::ForumUser
  include Roleable

  has_person_name
  has_many :related_vanbans, dependent: :destroy, class_name: 'Vanban'
  has_many :vanban_users, dependent: :destroy
  has_many :vanbans_through_users, through: :vanban_users, source: :vanban
  has_many :donvi_users, dependent: :destroy
  has_many :donvis , through: :donvis_users, source: :donvi
  has_many :congviecs
  has_many :congviec_users, dependent: :destroy
  has_many :congviecs_cv, through: :congviec_users, source: :congviec
  has_many :notifications, as: :recipient, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable,:omniauthable,
         omniauth_providers: %i[ google_oauth2 ]
  def self.ransackable_attributes(auth_object = nil)
    ["admin", "name","confirmation_sent_at", "confirmation_token", "confirmed_at", "created_at", "email", "encrypted_password", "first_name", "id", "last_name", "moderator", "remember_created_at", "reset_password_sent_at", "reset_password_token", "roles", "unconfirmed_email", "updated_at"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["congviec_users", "congviecs_cv", "donvi_users", "donvis", "forum_posts", "forum_subscriptions", "forum_threads", "related_vanbans", "roles", "vanban_users", "vanbans_cv", "vanbans_through_users"]
  end

  def self.from_omniauth(auth)
    user = User.where(provider: auth.try(:provider) || auth["provider"], uid: auth.try(:uid) || auth["uid"]).first
    if user
      user.update(
        access_token: auth.credentials.token,
        expires_at: auth.credentials.expires_at,
        refresh_token: auth.credentials.refresh_token
      )
      return user
    else
      registered_user = User.where(provider: auth.try(:provider) || auth["provider"], uid: auth.try(:uid) || auth["uid"]).first || User.where(email: auth.try(:info).try(:email) || auth["info"]["email"]).first
      if registered_user
        unless registered_user.provider == (auth.try(:provider) || auth["provider"]) && registered_user.uid == (auth.try(:uid) || auth["provider"])
          registered_user.update(provider: auth.try(:provider) || auth["provider"], uid: auth.try(:uid) || auth["uid"])
        end
        return registered_user
      else
        user = User.new(:provider => auth.try(:provider) || auth["provider"], uid: auth.try(:uid) || auth["uid"])
        user.email = auth.try(:info).try(:email) || auth["info"]["email"]
        user.password = Devise.friendly_token[0,20]
        user.first_name = auth.info.name.split(" ")[0]
        user.last_name = auth.info.name.split(" ")[1]
        user.access_token = auth.credentials.token
        user.expires_at = auth.credentials.expires_at
        user.refresh_token = auth.credentials.refresh_token
        user.save
        puts user
      end
      user
    end
  end

  def expired?
    expires_at < Time.current.to_i
  end 

  def name
    "#{first_name} #{last_name}"
  end


  
end
