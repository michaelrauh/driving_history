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
    hours = (end_time - start_time) / SECONDS_PER_HOUR

    @miles = distance
    @speed = distance / hours
  end

  def valid?
    @speed > 5 && @speed < 100
  end
end
