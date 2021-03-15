class Character < ApplicationRecord
  belongs_to :level

  validates_presence_of %i[name shape coordinates]
  validates_inclusion_of :shape, in: %w[poly rect circle]

  def as_json(options = {})
    super(only: %i[id name], **options)
  end
end

class CharacterRectArea
  def initialize(coordinates); end

  private

  attr_accessor :shape, :coordinates
end

class CharacterArea
  def for(shape:, coordinates:)
    case shape
    when 'rect'
      CharacterRectArea.new(coordinates)
    else
      raise ArgumentError, "no character area for #{shape}"
    end
  end
end
