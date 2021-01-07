#!/usr/bin/env ruby


require 'set'
require 'pp'

filename = ARGV[0]
lines = File.readlines(filename)

floors = lines.map do |line|
  stuff = line.split('a ').map(&:chomp)
  generators = stuff.select { |s| s.include? 'generator'  }
  chips = stuff.select { |s| s.include? 'microchip'  }
  floor = []
  floor += generators.map do |gen|
    [:gen, gen.split(' ')[0].to_sym]
  end
  floor += chips.map do |chip|
    [:chip, chip.split('-')[0].to_sym]
  end
  p floor
  floor
end


count = floors.flatten(1).length
p count
$seen = Hash.new
