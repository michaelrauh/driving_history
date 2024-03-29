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

  def report_highway
    return "#{name}: 0% highway" if @trips.empty?

    "#{name}: #{highway_miles_percent}% highway"
  end

  def miles
    @trips.map(&:miles).reduce(0, &:+)
  end

  def ==(other)
    name == other.name
  end

  private

  def highway_miles_percent
    ((highway_miles.to_f/miles) * 100).round
  end

  def highway_miles
    highway_miles = 0
    trips.each do |trip|
      if trip.speed >= 50
        highway_miles += trip.miles
      end
    end
    highway_miles
  end

  def speed
    total_distance = @trips.map(&:miles).reduce(&:+)
    total_time = @trips.map { |trip| trip.miles / trip.speed }.reduce(&:+)
    total_distance / total_time
  end
end
