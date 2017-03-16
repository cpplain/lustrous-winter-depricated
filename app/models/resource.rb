class Resource < ApplicationRecord
  belongs_to :subject
  belongs_to :resource_type
  belongs_to :organization
  has_many :ratings, as: :morphic_rating
  has_many :reviews
  validates :name, presence: true
  validates :description, presence: true
  validates :medium, presence: true
  validates :free, presence: true
end
