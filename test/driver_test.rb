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

  def test_report_reports_on_single_trip
    trip = Minitest::Mock.new
    trip.expect(:speed, 15.3)
    trip.expect(:distance, 5.7)

    @subject.add_trip(trip)
    @subject.name = 'Dan'

    assert_equal('Dan: 6 miles @ 15 mph', @subject.report)
  end
end
