class Author < ApplicationRecord
  has_many :resource_authors
  has_many :resources, through: :resource_authors
  validates :first, presence: true
  validates :last, presence: true
end
