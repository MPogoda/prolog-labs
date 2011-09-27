#!/usr/bin/ruby

ARGV[1] ||= 9999999999999999

ARGV[0].to_i.times do
  puts "#{rand(ARGV[1].to_i)}."
end
