class Event < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :user_events, dependent: :destroy
  geocoded_by :place
  after_validation :geocode, if: :will_save_change_to_place?

  validates :date, presence: true

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:date, :details, :place],
    associated_against: {
      game: [:name]
    },
    using: {
      tsearch: { prefix: true }
    }
end
