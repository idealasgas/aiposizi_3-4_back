class Classroom < ApplicationRecord
  belongs_to :teacher, optional: true

  validates :number, presence: true
end
