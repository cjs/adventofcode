#!/usr/bin/env ruby

require './lib/display'

d = Display.new(50,6)

instructions = File.open('input')
instructions.each do |i|
  tokens = i.split(' ')
  if tokens[0] == 'rect'
    a, b = tokens[1].split('x')
    d.rect(Integer(a), Integer(b))
  end
  if tokens[0] == 'rotate'
    if tokens[1] == 'row'
      a = tokens[2].tr('y=', '')
      d.rotate_row(Integer(a), Integer(tokens[4]))
    end
    if tokens[1] == 'column'
      a = tokens[2].tr('x=', '')
      d.rotate_column(Integer(a), Integer(tokens[4]))
    end
  end
  puts d
  puts
end
puts "Part 1: #{d.count}"

start = 0
10.times do
  d.grid[0..6].transpose[start, 5].transpose.each do |row|
    row.each { |cell| print cell }
    puts
  end
  start = start + 5
  puts
end
