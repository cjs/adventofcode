#!/usr/bin/env ruby
require './lib/decompress'

input = File.open('input')

s = input.readline
p "Part 1: #{s.chomp.decompress.size}"
