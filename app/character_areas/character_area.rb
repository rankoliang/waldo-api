require_relative 'character_rect_area'

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
