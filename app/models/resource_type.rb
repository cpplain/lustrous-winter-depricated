class ResourceType < ApplicationRecord
  has_many :resources
  validates :resource_type, presence: true
end
