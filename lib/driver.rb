# Model a driver based upon name and trips
class Driver
  attr_accessor :name

  def ==(other)
    name == other.name
  end
end
