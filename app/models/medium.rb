class Medium < ApplicationRecord
  audited
  belongs_to :resource
  has_many :ratings
end
