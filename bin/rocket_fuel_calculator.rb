#!/usr/bin/env ruby

require_relative '../lib/rocket_launcher'

mass = ARGV[0].to_i
path = ARGV[1..-1]&.each_slice(2)&.map { |action, target| [action.to_sym, target&.downcase] }

def print_usage
  puts "Usage: rocket_fuel_calculator <mass> <path>"
  puts "Example: rocket_fuel_calculator 28801 launch earth land moon launch moon land earth"
end

if mass <= 0 || path.empty? || path.any? { |action, target| ![:launch, :land].include?(action) }
  print_usage
  exit(1)
end

total_fuel = RocketLauncher.new(mass, path).fuel_required

if total_fuel
  puts "Total rocket fuel required: #{total_fuel} kg"
end
