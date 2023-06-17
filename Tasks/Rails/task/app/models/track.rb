class Track < ApplicationRecord
  has_many :students
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
