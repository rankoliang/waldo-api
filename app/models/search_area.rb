require_relative '../search_areas/rect_search_area'

class SearchArea < ApplicationRecord
  belongs_to :character
  belongs_to :level

  validates_presence_of %i[shape coordinates]
  validates_inclusion_of :shape, in: %w[rect]

  def as_json(options = {})
    search_area_as_json = super(only: [:id], **options)
    search_area_as_json['search_area_id'] = search_area_as_json.delete 'id'

    character.as_json.merge(search_area_as_json)
  end

  def found?(x:, y:)
    self.class.for(self).contains?(x: x, y: y)
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
