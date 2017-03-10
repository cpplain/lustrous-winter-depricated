class Resource < ApplicationRecord
  belongs_to :subject
  validates :name, presence: true
  validates :description, presence: true
end
