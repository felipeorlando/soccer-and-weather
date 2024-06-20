require_relative 'services/weather'
require_relative 'services/soccer'

Weather.new.get_min_spread
Soccer.new.get_smallest_hits_and_goals_difference