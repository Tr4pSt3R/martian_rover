# Defines surface dimensions of Mars as a 2-D plane
class Surface
  class BlackHoleError < StandardError; end
  class CoordinateTooLarge < StandardError; end

  MAXIMUM_COORDINATE_SIZE = 50

  attr_reader :x, :y

  def initialize(x:, y:)
    raise(BlackHoleError, 'Hmm,.. these dimensions are strange!') if
      dimensions_are_strange?(x, y)
    raise(CoordinateTooLarge, 'The maximum value for any coordinate is 50') if
      coordinate_too_large?(x, y)

    @x = x
    @y = y
  end

  private

  def dimensions_are_strange?(x, y)
    x.nil? || y.nil? || x.zero? || y.zero?
  end

  def coordinate_too_large?(x, y)
    x > MAXIMUM_COORDINATE_SIZE || y > MAXIMUM_COORDINATE_SIZE
  end
end
