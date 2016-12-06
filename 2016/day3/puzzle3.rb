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

p 'Part 1'
p counter

instructions.rewind
counter = 0
index = 0
t = Array.new(3)
t.each_index do |i|
  t[i] = Array.new(3)
end
instructions.each do |line|
  t[0][index], t[1][index], t[2][index] = line.chomp.split(' ').map(&:to_i)
  if index == 2
    t.each_index do |i|
      a, b, c = t[i]
      counter = counter + 1 if validtriangle(a,b,c)
    end
    index = 0
  else
    index = index + 1
  end
end

p 'Part 2'
p counter

