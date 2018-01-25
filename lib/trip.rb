# Models a single instance of driving a car
class Trip
  SECONDS_PER_HOUR = 3600

  attr_accessor :miles
  attr_accessor :speed

  def initialize
    @miles = 0
    @speed = 0
  end

  def configure(start_time, end_time, distance)
    @miles = distance
    hours = (end_time - start_time) / SECONDS_PER_HOUR
    @speed = distance / hours
  end
end
