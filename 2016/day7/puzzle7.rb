#!/usr/bin/env ruby

require './lib/ip7'

tls_count = File.open('input').reduce(0) do |count, ip| 
  IPaddress.new(ip.chomp).support_tls? ? count += 1 : count
  count
end

p "Part 1: #{tls_count}"

tls_count = File.open('input').reduce(0) do |count, ip| 
    IPaddress.new(ip.chomp).support_ssl? ? count += 1 : count
    count
end
p "Part 2: #{tls_count}"
