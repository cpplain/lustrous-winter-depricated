class Resource < ApplicationRecord
  audited
  belongs_to :subject
  has_many :ratings, as: :morphic_rating
  has_many :reviews
  validates :name, presence: true
  validates :description, presence: true
  validates :medium, presence: true
  validates :free, presence: true
end
