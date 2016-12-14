#!/usr/bin/env ruby

require './lib/ip7'

ip_count = File.open('input').reduce([0,0]) do |count, ip| 
  count[0] += 1 if IPaddress.new(ip.chomp).support_tls?
  count[1] += 1 if IPaddress.new(ip.chomp).support_ssl?
  count
end

p "Part 1: #{ip_count[0]}"
p "Part 2: #{ip_count[1]}"
