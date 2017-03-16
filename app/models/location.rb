class Location < ApplicationRecord
  belongs_to :resource
  belongs_to :city
end
