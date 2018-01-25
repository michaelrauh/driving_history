require_relative 'trip.rb'

# Returns new instances of trips
class TripProvider
  def make
    Trip.new
  end
end
