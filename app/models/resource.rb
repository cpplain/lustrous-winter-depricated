class Resource < ApplicationRecord
  audited
  belongs_to :subject
  validates :name, presence: true
  validates :description, presence: true
end
