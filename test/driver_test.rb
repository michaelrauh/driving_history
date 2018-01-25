require 'minitest/autorun'
require_relative '../lib/driver.rb'

class DriverTest < Minitest::Test
  def setup
    @subject = Driver.new
  end

  def test_add_trip_registers_trip
    trip = Minitest::Mock.new
    @subject.add_trip(trip)
    assert_equal([trip], @subject.trips)
  end
end
