# Model a driver based upon name and trips
class Driver
  attr_accessor :name
  attr_accessor :trips

  def initialize
    @trips = []
  end

  def add_trip(trip)
    @trips << trip if trip.valid?
  end

  def report
    return "#{name}: 0 miles" if @trips.empty?

    "#{name}: #{miles.round} miles @ #{speed.round} mph"
  end

  def miles
    @trips.map(&:miles).reduce(&:+)
  end

  def ==(other)
    name == other.name
  end

  private

  def speed
    (@trips.map { |trip| trip.speed * trip.miles }.reduce(&:+) / miles)
  end
end
