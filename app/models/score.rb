class Score < ApplicationRecord
  belongs_to :level

  validates_presence_of %i[name seconds]

  validates_numericality_of :seconds, greater_than: 0

  validates_length_of :name, maximum: 20
end
