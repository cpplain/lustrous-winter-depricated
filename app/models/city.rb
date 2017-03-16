class City < ApplicationRecord
  belongs_to :state
  has_many :locations
  has_many :resources, through: :locations
  validates :name, presence: true
end
