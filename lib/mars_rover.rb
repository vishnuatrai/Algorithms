#MARS ROVER
#       A squad of robotic rovers are to be landed by NASA on a plateau on Mars.
#
#       This plateau, which is curiously rectangular, must be navigated by the
#       rovers so that their on-board cameras can get a complete view of the
#       surrounding terrain to send back to Earth.
#
#       A rover’s position and location is represented by a combination of x and y
#       co-ordinates and a letter representing one of the four cardinal compass points.
#       The plateau is divided up into a grid to simplify navigation. An example position
#       might be 0, 0, N, which means the rover is in the bottom left corner and facing North.
#
#       In order to control a rover, NASA sends a simple string of letters. The possible
#       letters are ‘L’, ‘R’ and ‘M’. ‘L’ and ‘R’ makes the rover spin 90 degrees left or right
#       respectively, without moving from its current spot.‘M’ means move forward one grid point,
#       and maintain the same heading.
#
#       Assume that the square directly North from (x, y) is (x, y+1).
#
#INPUT
#       The first line of input is the upper-right coordinates of the plateau, the lower-left
#       coordinates are assumed to be 0,0.
#
#       The rest of the input is information pertaining to the rovers that have been deployed.
#       Each rover has two lines of input. The first line gives the rover’s position, and the
#       second line is a series of instructions telling the rover how to explore the plateau.
#
#       The position is made up of two integers and a letter separated by spaces, corresponding
#       to the x and y co-ordinates and the rover’s orientation.
#
#       Each rover will be finished sequentially, which means that the second rover won’t start
#       to move until the first one has finished moving.
#Another reference code - https://github.com/dalibor/mars_rover
module Directions
  def self.from_s(direction)
    case
      when direction == 'N'
        NORTH
      when direction == 'E'
        EAST
      when direction == 'W'
        WEST
      when direction == 'S'
        SOUTH
    end
  end

  class North
    def turn_left
      WEST
    end

    def turn_right
      EAST
    end

    def move(currentPosition)
      x = Integer(currentPosition[0])
      y = Integer(currentPosition[1]) + 1

      [x, y]
    end

    def to_s
      "N"
    end
  end

  class West
    def turn_left
      SOUTH
    end

    def turn_right
      NORTH
    end

    def move(currentPosition)
      x = Integer(currentPosition[0]) - 1
      y = Integer(currentPosition[1])

      [x, y]
    end

    def to_s
      "W"
    end
  end

  class South
    def turn_left
      EAST
    end

    def turn_right
      WEST
    end

    def move(currentPosition)
      x = Integer(currentPosition[0])
      y = Integer(currentPosition[1]) - 1

      [x, y]
    end

    def to_s
      "S"
    end
  end

  class East
    def turn_left
      NORTH
    end

    def turn_right
      SOUTH
    end

    def move(currentPosition)
      x = Integer(currentPosition[0]) + 1
      y = Integer(currentPosition[1])

      [x, y]
    end

    def to_s
      "E"
    end
  end

  NORTH = North.new
  SOUTH = South.new
  EAST  = East.new
  WEST  = West.new
end

class Rover
  attr_reader :direction, :position

  def initialize(initial_direction, current_position=[0,0])
    @direction = initial_direction
    @position = current_position
  end

  def turn_left
    @direction = @direction.turn_left
  end

  def turn_right
    @direction = @direction.turn_right
  end

  def move
    @position = @direction.move(@position)
  end

  def to_s
    "#{position[0]} #{position[1]} #{direction}"
  end
end

class Operator
  def initialize(rover)
    @rover = rover
  end

  def receive(command_line)
    command_line.each_char do |command|
      case
        when command == 'L'
          @rover.turn_left
        when command == 'R'
          @rover.turn_right
        when command == 'M'
          @rover.move
      end
    end
  end
end

puts "=========="
plateau = ARGF.gets
while !ARGF.eof
  rover_position = ARGF.gets
  position = rover_position.split[0, 2]
  direction = Directions.from_s(rover_position.split[2])

  rover = Rover.new(direction, position)
  Operator.new(rover).receive ARGF.gets

  puts rover
end

puts "=========="
