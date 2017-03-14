class Review < ApplicationRecord
  audited
  belongs_to :resource
  has_many :ratings, as: :morphic_rating
  validates :comment, presence: true
end
