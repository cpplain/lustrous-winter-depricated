class Resource < ApplicationRecord
  belongs_to :subject
  belongs_to :resource_type
  belongs_to :organization
  has_many :reviews
  has_many :ratings, as: :morphic_rating
  has_many :resource_authors
  has_many :authors, through: :resource_authors
  has_many :locations
  has_many :cities, through: :locations
  validates :name, presence: true
  validates :description, presence: true
  validates :level, presence: true
  validates :free, presence: true
end
