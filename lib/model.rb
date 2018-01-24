require_relative 'driver_provider.rb'

# Top level model for data domain
class Model
  attr_accessor :drivers
  attr_accessor :driver_provider

  def initialize
    @drivers = []
    @driver_provider = DriverProvider.new
  end

  def train(description)
    lines = description.split('\n')
    lines.each do |line|
      tokens = line.split(' ')
      tokens.shift
      driver = @driver_provider.make
      driver.name = tokens.shift
      drivers << driver
    end
  end
end
