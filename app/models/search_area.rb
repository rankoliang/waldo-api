require_relative '../search_areas/rect_search_area.rb'

class SearchArea < ApplicationRecord
  belongs_to :character
  belongs_to :level

  validates_presence_of %i[shape coordinates]
  validates_inclusion_of :shape, in: %w[rect]

  def found?(x:, y:)
    area.contains?(x: x, y: y)
  end

  def area
    @area ||= SearchArea.for(self)
  end

  def self.for(search_area)
    case search_area.shape
    when 'rect'
      RectSearchArea.new(search_area.coordinates)
    else
      raise ArgumentError, "no search area for #{shape}"
    end
  end
end
