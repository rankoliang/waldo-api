class RectSearchArea
  attr_reader :coordinates

  def initialize(coordinates)
    self.coordinates = coordinates.split(',').map(&:to_i)
  end

  def contains?(x:, y:)
    x1, y1, x2, y2 = coordinates

    x.between?(x1, x2) && y.between?(y1, y2)
  end

  private

  attr_writer :coordinates
end
