class Subject < ApplicationRecord
  audited
  belongs_to :parent, class_name: 'Subject', optional: true
  has_many :children, class_name: 'Subject', foreign_key: 'parent_id'
  has_many :resources
  validates :name, presence: true
end
