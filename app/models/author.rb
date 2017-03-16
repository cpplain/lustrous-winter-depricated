class Author < ApplicationRecord
  has_many :resource_authors
  has_many :resources, through: :resource_authors
  validations :first, presence: true
  validations :last, presence: true
end
