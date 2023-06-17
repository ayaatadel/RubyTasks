class Student < ApplicationRecord

    belongs_to :track, foreign_key: 'tracks_id'
    validates :name, presence: true
    validates :age, presence: true, numericality: { only_integer: true }
    validates :IDno, presence: true, uniqueness: true, numericality: { only_integer: true }
    validates :track, presence: true 
end
