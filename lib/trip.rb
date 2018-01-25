# Models a single instance of driving a car
class Trip
  attr_accessor :miles

  def initialize
    @miles = 0
  end

  def configure(start_time, end_time, distance)
    @miles = distance
  end
end
