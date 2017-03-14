class Rating < ApplicationRecord
  audited
  belongs_to :morphic_rating, polymorphic: true
  validates :recommend, presence: true
end
