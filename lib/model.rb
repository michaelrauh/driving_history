require_relative 'driver_provider.rb'
require_relative 'trip_provider.rb'
require 'time'

# Top level model for data domain
class Model
  attr_accessor :drivers
  attr_accessor :driver_provider
  attr_accessor :trip_provider

  def initialize
    @drivers = {}
    @driver_provider = DriverProvider.new
    @trip_provider = TripProvider.new
  end

  def train(description)
    description.split('\n').each do |line|
      tokens = line.split(' ')
      command, driver_name = tokens.shift(2)
      if command == 'Driver'
        add_driver(driver_name)
      else
        add_trip(driver_name, tokens.shift(3))
      end
    end
  end

  private

  def add_driver(driver_name)
    driver = @driver_provider.make
    driver.name = driver_name
    drivers[driver_name] = driver
  end

  def add_trip(driver_name, args)
    trip = trip_provider.make
    trip.configure(driver_name, Time.parse(args.shift),
                   Time.parse(args.shift), args.shift.to_f)
    drivers[driver_name].add_trip(trip)
  end
end
