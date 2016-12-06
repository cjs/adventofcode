#!/usr/bin/env ruby
#
require './lib/keypad.rb'

puts "Part 1"
keys = []
rows = Array.new(3,3)
values = (1..9).to_a.reverse
keypad = Keypad.new(rows, values)
start = keypad[1,1]
nav = Navigate.new(start)

instructions = File.open('input')
instructions.each do |line|
  keys << nav.find_button(line.chomp.chars).value
end
p keys

instructions.rewind
puts
puts "Part 2"
keys = []
rows = [1, 3, 5, 3, 1]
values = %w(1 2 3 4 5 6 7 8 9 A B C D).reverse
keypad = Keypad.new(rows, values)
start = keypad[2,0]
nav = Navigate.new(start)
instructions.each do |line|
  keys << nav.find_button(line.chomp.chars).value
end

p keys
