class Rating < ApplicationRecord
  audited
  belongs_to :medium
  belongs_to :review
  validates :recommend, presence: true
end
