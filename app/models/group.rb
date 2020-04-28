class Group < ApplicationRecord
  has_many :students
  belongs_to :teacher, optional: true

  validates :name, presence: true
end
