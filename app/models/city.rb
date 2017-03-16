class City < ApplicationRecord
  belongs_to :state
  has_many :locations
  has_many :resources, through: :locations
  validations :name, presence: true
end
