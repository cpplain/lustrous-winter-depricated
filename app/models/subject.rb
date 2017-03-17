class Subject < ApplicationRecord
  belongs_to :parent, class_name: 'Subject', optional: true
  has_many :children, class_name: 'Subject', foreign_key: 'parent_id'
  has_many :resources
  validates :name, presence: true

  def self.top_level
    self.where(parent_id: nil)
  end
end
