class Teacher < ApplicationRecord
  has_one :group
  has_one :classroom

  validates :name, presence: true
  validates :surname, presence: true
  validates :subject, presence: true
end
