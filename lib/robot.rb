require_relative '../lib/surface'

# Robot class handles all robotic operations.
# Robots using this class are self-aware of the surface they occupy
class Robot
  class InvalidOrientation < StandardError; end
  class Lost < StandardError; end
  class YouAreTooBossy < StandardError; end

  CARDINAL_POINTS = %w[N W S E].freeze
  MAX_INSTRUCTIONS = 100

  @danger_points = []

  class << self
    attr_accessor :danger_points
  end

  attr_accessor :x, :y, :orientation, :surface, :lost

  def initialize(x:, y:, orientation:, surface: nil)
    raise(InvalidOrientation) unless CARDINAL_POINTS.include?(orientation)

    @x = x.to_i
    @y = y.to_i
    @orientation = orientation
    @surface = surface
    @lost = nil
  end

  def move!
    case orientation
    when 'N' then move_northwards
    when 'S' then move_southwards
    when 'W' then move_westwards
    when 'E' then move_eastwards
    end
  rescue Robot::Lost
    self.lost = 'LOST'
    Robot.danger_points << [x, y, orientation].join(' ')
  end

  def left!
    case orientation
    when 'N' then self.orientation = 'W'
    when 'W' then self.orientation = 'S'
    when 'S' then self.orientation = 'E'
    when 'E' then self.orientation = 'N'
    end
  end

  def right!
    case orientation
    when 'N' then self.orientation = 'E'
    when 'E' then self.orientation = 'S'
    when 'S' then self.orientation = 'W'
    when 'W' then self.orientation = 'N'
    end
  end

  def perform(instruction_set = '')
    instruction_set = instruction_set.to_s.chars
    raise YouAreTooBossy if instruction_set.count > MAX_INSTRUCTIONS

    instruction_set.each do |instruction|
      unless lost
        case instruction
        when 'F' then move! unless perilous?
        when 'L' then left!
        when 'R' then right!
        end
      end
    end
  end

  def position
    [x, y, orientation, lost].join(' ').strip
  end

  private

  def perilous?
    Robot.danger_points.include?([x, y, orientation].join(' '))
  end

  def move_northwards
    raise Robot::Lost if (y + 1) > surface.y.to_i

    self.y = y + 1
  end

  def move_southwards
    raise Robot::Lost if (y - 1).negative?

    self.y = y - 1
  end

  def move_westwards
    raise Robot::Lost if (x - 1).negative?

    self.x = x - 1
  end

  def move_eastwards
    raise Robot::Lost if (x + 1) > surface.x.to_i

    self.x = x + 1
  end
end
