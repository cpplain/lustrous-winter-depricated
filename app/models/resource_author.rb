class ResourceAuthor < ApplicationRecord
  belongs_to :resource
  belongs_to :author
end
