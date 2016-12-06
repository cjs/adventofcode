#!/usr/bin/env ruby

def validtriangle(a, b, c)
   a + b > c and a + c > b and b + c > a
end

counter = 0
instructions = File.open('input')
instructions.each do |line|
  a, b, c = line.chomp.split(' ').map(&:to_i)
  counter = counter + 1 if validtriangle(a, b, c)
end
p counter
