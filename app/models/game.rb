class Game < ApplicationRecord
  has_many :events, dependent: :destroy
end
