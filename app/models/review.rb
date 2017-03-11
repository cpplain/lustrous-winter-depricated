class Review < ApplicationRecord
  audited
  belongs_to :resource
  has_many :ratings
  validates :comment, presence: true
end
