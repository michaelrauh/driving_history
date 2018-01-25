require 'minitest/autorun'
require 'time'

class ModelTest < Minitest::Test
  def setup
    @subject = Model.new
  end

  def test_model_train_generates_a_driver_model_for_each_driver_command
    driver = mock_driver('Dan')
    driver2 = mock_driver('Alex')
    driver_provider = mock_driver_provider([driver, driver2])

    @subject.driver_provider = driver_provider

    @subject.train('Driver Dan\nDriver Alex')

    assert_mock driver
    assert_mock driver2
  end

  def test_model_train_adds_a_trip_to_appropriate_driver_for_trip_command
    trip = mock_trip
    driver = mock_driver('Dan')
    driver.expect(:add_trip, nil, [trip])

    trip_provider = mock_trip_provider(trip)

    driver_provider = mock_driver_provider([driver])

    @subject.trip_provider = trip_provider
    @subject.driver_provider = driver_provider

    @subject.train('Driver Dan\nTrip Dan 07:15 07:45 17.3')

    assert_mock driver
  end

  def test_model_report_returns_formatted_string_for_driver
    driver = mock_report_driver('Alex: 42 miles @ 34 mph', 42)
    @subject.drivers['Alex'] = driver

    assert_equal('Alex: 42 miles @ 34 mph', @subject.report)
  end

  def test_model_report_returns_drivers_in_miles_driven_order_descending
    driver = mock_report_driver('Alex: 40 miles @ 10 mph', 40)
    @subject.drivers['Alex'] = driver

    driver2 = mock_report_driver('Bob: 55 miles @ 30 mph', 55)
    @subject.drivers['Bob'] = driver2

    expected = 'Bob: 55 miles @ 30 mph\nAlex: 40 miles @ 10 mph'

    assert_equal(expected, @subject.report)
  end

  private

  def mock_report_driver(report, distance)
    driver = Minitest::Mock.new
    driver.expect(:report, report)
    driver.expect(:miles, distance)
  end

  def mock_trip_provider(trip)
    trip_provider = Minitest::Mock.new
    trip_provider.expect(:make, trip)
    trip_provider
  end

  def mock_trip
    trip = Minitest::Mock.new
    trip.expect(:configure, nil, [Time.parse('07:15'),
                                  Time.parse('07:45'), 17.3])
    trip
  end

  def mock_driver(name)
    driver = Minitest::Mock.new
    driver.expect(:name=, nil, [name])
    driver
  end

  def mock_driver_provider(drivers)
    driver_provider = Minitest::Mock.new
    drivers.each do |driver|
      driver_provider.expect(:make, driver)
    end

    driver_provider
  end
end
