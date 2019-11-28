class Game < ApplicationRecord
  has_many :events, dependent: :destroy
  mount_uploader :photo, PhotoUploader
  validates :name, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [:name],
    using: {
      tsearch: { prefix: true }
    }
end
