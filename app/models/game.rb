class Game < ApplicationRecord
  has_many :events, dependent: :destroy
  mount_uploader :photo, PhotoUploader
  validates :name, presence: true
end
