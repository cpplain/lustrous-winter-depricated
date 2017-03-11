class Resource < ApplicationRecord
  audited
  belongs_to :subject
  has_many :media
  has_many :reviews
  has_many :ratings, through: :media
  validates :name, presence: true
  validates :description, presence: true
end
