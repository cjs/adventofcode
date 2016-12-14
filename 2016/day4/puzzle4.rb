#!/usr/bin/env ruby
#

require './lib/room'

rooms = File.open('input').reduce(0) do |sum, room_id|
  r = Room.new(room_id)
  r.valid? ? sum += r.sector : sum
  sum
end

p 'Part 1'
p rooms

puts
puts 'Part 2'

input = File.open('input')
input.each do |room|
  r = Room.new(room)
  p r.sector if r.valid? and r.decrypt == 'northpole object storage'
end

