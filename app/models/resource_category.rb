class ResourceCategory < ApplicationRecord
  has_many :children, class_name: 'ResourceCategory', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'ResourceCategory', optional: true
end
