class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise :omniauthable, omniauth_providers: [:facebook, :github]

  mount_uploader :photo, PhotoUploader
  has_many :events
  has_many :user_events, dependent: :destroy

  def self.from_facebook(auth)
    where(facebook_id: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.remote_photo_url = auth.info.image
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.from_github(auth)
    where(github_id: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.remote_photo_url = auth.info.image
      user.password = Devise.friendly_token[0,20]
    end
  end
end
