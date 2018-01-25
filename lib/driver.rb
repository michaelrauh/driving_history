# Model a driver based upon name and trips
class Driver
  attr_accessor :name
  attr_accessor :trips

  def initialize
    @trips = []
  end

  def add_trip(trip)
    @trips << trip
  end

  def report
    "#{name}: #{round_distance} miles @ #{round_speed} mph"
  end

  def round_distance
    @trips.first.distance.round
  end

  def round_speed
    @trips.first.speed.round
  end

  def ==(other)
    name == other.name
  end
end
