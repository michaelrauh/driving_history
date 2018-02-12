require 'minitest/autorun'
require_relative '../lib/driver.rb'

class DriverTest < Minitest::Test
  def setup
    @subject = Driver.new
  end

  def test_add_trip_registers_valid_trip
    trip = Minitest::Mock.new
    trip.expect(:valid?, true)
    @subject.add_trip(trip)
    assert_equal([trip], @subject.trips)
  end

  def test_add_trip_registers_does_not_register_invalid_trips
    trip = Minitest::Mock.new
    trip.expect(:valid?, false)
    @subject.add_trip(trip)
    assert_equal([], @subject.trips)
  end

  def test_report_reports_on_single_trip
    @subject.add_trip(make_mock_trip(15.3, 5.7, true))
    @subject.name = 'Dan'

    assert_equal('Dan: 6 miles @ 15 mph', @subject.report)
  end

  def test_report_reports_on_no_trips
    @subject.name = 'Dan'

    assert_equal('Dan: 0 miles', @subject.report)
  end

  def test_miles_is_zero_for_no_trips
    @subject.name = 'Dan'

    assert_equal(0, @subject.miles)
  end

  def test_report_reports_on_multiple_trips
    @subject.add_trip(make_mock_trip(15.3, 5.7, true))
    @subject.add_trip(make_mock_trip(4, 58, true))
    @subject.add_trip(make_mock_trip(4, 1.4, true))

    @subject.name = 'Dan'

    assert_equal('Dan: 65 miles @ 4 mph', @subject.report)
  end

  def test_report_highway_returns0PercentForNoTrips
    @subject.name = 'Dan'

    assert_equal('Dan: 0% highway', @subject.report_highway)
  end

  def test_report_highway_reports_percentage_trips_highway
    @subject.name = 'Dan'

    @subject.add_trip(make_mock_trip(75, 10, true))
    @subject.add_trip(make_mock_trip(4, 10, true))

    assert_equal('Dan: 50% highway', @subject.report_highway)
  end

  private

  def make_mock_trip(speed, miles, valid)
    trip = Minitest::Mock.new
    trip.expect(:speed, speed)
    trip.expect(:miles, miles)
    trip.expect(:miles, miles)
    trip.expect(:miles, miles)
    trip.expect(:valid?, valid)
    trip
  end
end
