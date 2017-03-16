class Rating < ApplicationRecord
  belongs_to :morphic_rating, polymorphic: true
  validates :recommend, presence: true
end
