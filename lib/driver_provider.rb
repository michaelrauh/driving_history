require_relative 'driver.rb'

# Returns new instances of drivers
class DriverProvider
  def make
    Driver.new
  end
end
