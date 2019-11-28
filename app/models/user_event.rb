class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates_uniqueness_of :event, scope: :user
end
