#!/usr/bin/env ruby
#
# Read and store input file into an array
#

# Reperesent a position
class Position
  attr_accessor :xloc, :yloc, :direction

  def initialize(x, y, dir)
    self.xloc = x
    self.yloc = y
    self.direction = dir
    @position_history = ['X:0 Y:0']
  end

  def to_s
    directions = %w(N E S W)
    'X: ' + @xloc.to_s + ' Y: ' + @yloc.to_s + ' Facing: ' + directions[@direction / 90]
  end

  def distance
    @xloc.abs + @yloc.abs
  end

  def blocks_from(start_pos)
    (@xloc - start_pos.xloc).abs + (@yloc - start_pos.yloc).abs
  end

  def position
    'X:' + @xloc.to_s + ' Y:' + @yloc.to_s
  end
end

# Perform Navigation, keeping track of each position touched
class Navigation
  attr_accessor :position_history, :start_position, :current_position
  def initialize(pos)
    @start_position = pos
    @current_position = pos
    @position_history = [pos]
  end

  def move(instruction)
    turn = instruction.slice!(0)
    case turn
    when 'R'
      facing = ((@current_position.direction + 90) % 360).abs
    when 'L'
      facing = ((@current_position.direction - 90) % 360).abs
    else
      raise 'Bad Direction'
    end
    xlocnew = @current_position.xloc + Math::sin(facing * Math::PI / 180).round * instruction.to_i
    ylocnew = @current_position.yloc + Math::cos(facing * Math::PI / 180).round * instruction.to_i
    if xlocnew != @current_position.xloc
      steps = (@current_position.xloc..xlocnew).to_a.drop(1)
      steps.each do |x|
        @position_history << Position.new(x, @current_position.yloc, facing)
      end
    else
      steps = (@current_position.yloc..ylocnew).to_a.drop(1)
      steps.each do |y|
        @position_history << Position.new(@current_position.xloc, y, facing)
      end
    end
    @current_position = Position.new(xlocnew, ylocnew, facing)
  end
end

nav = Navigation.new(Position.new(0, 0, 0))
instructions = File.read('input.txt').chomp.split(', ')

#instructions = %w(R8 R4 R4 R8)
p nav.current_position.to_s

instructions.each do |i|
  nav.move(i)
end

print "Ended up #{nav.current_position.blocks_from(nav.start_position)} blocks away\n"
double_visit = nil
position_counts = {}
nav.position_history.each do |pos|
  unless double_visit
    if position_counts.key? pos.position
      puts 'double visit found'
      double_visit = pos
    else
      position_counts[pos.position] = 1

    end
  end
end

if double_visit
  print "#{double_visit.position} was first visited twice."
  print "It is #{double_visit.blocks_from(nav.start_position)} blocks away.\n"
end
