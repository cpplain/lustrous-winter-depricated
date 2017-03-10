class Subject < ApplicationRecord
  has_many :children, class_name: 'Subject', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Subject', optional: true
  has_many :resources
  validates :name, presence: true
end
