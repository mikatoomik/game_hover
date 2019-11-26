class Event < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :user_events, dependent: :destroy
end
