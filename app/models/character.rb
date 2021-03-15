require_relative '../character_areas/character_area'

class Character < ApplicationRecord
  belongs_to :level

  validates_presence_of %i[name shape coordinates]
  validates_inclusion_of :shape, in: %w[poly rect circle]

  def as_json(options = {})
    super(only: %i[id name], **options)
  end

  def found?(x:, y:)
    area.contains?(x: x, y: y)
  end

  def area
    @area ||= CharacterArea.for(shape: shape, coordinates: coordinates)
  end
end
