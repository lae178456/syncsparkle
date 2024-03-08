class Event < ApplicationRecord
  belongs_to :user
  has_many :eventlistings
  has_one_attached :photo
end
