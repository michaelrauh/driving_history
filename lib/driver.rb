# Model a driver based upon name and trips
class Driver
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def ==(other)
    name == other.name
  end
end
