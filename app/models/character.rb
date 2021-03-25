require_relative '../character_areas/character_area'

class Character < ApplicationRecord
  belongs_to :level

  has_one_attached :avatar

  validates_presence_of %i[name shape coordinates]
  validates_inclusion_of :shape, in: %w[poly rect circle]

  def as_json(options = {})
    super(only: %i[id name], methods: [:avatar_path], **options)
  end

  def found?(x:, y:)
    area.contains?(x: x, y: y)
  end

  def area
    @area ||= CharacterArea.for(shape: shape, coordinates: coordinates)
  end

  def avatar_path
    rails_blob_path(avatar, only_path: true) if avatar.attached?
  end
end
