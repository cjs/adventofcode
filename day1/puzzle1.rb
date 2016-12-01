#!/usr/bin/env ruby
#
# Read and store input file into an array
#

class Position
  attr_accessor :xloc, :yloc, :direction

  def initialize
    self.xloc = 0
    self.yloc = 0
    self.direction = 0
  end

  def to_s
    directions = ['N', 'E', 'S', 'W']
    'X: ' + @xloc.to_s + ' Y: ' + self.yloc.to_s + ' Facing: ' + directions[self.direction / 90]
  end

  def distance
    @xloc.abs + @yloc.abs
  end

  def navigate(instruction)
    turn = instruction.slice!(0)
    case turn
    when "R"
      @direction = ((@direction + 90) % 360).abs
    when "L"
      @direction = ((@direction - 90) % 360).abs
    else
      raise 'Bad Direction'
    end
    @xloc = @xloc + Math::sin(@direction * Math::PI / 180).round * instruction.to_i
    @yloc = @yloc + Math::cos(@direction * Math::PI / 180).round * instruction.to_i
  end

end


p = Position.new
instructions = File.read('input.txt').chomp.split(', ')


instructions.each do |i|
  p.navigate(i)
end

puts p.to_s
puts p.distance.to_s + ' blocks away'

