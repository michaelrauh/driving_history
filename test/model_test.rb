require 'minitest/autorun'
require 'time'

class ModelTest < Minitest::Test
  def setup
    @driver = Minitest::Mock.new
    @driver.expect(:name=, nil, ['Dan'])

    @driver_provider = Minitest::Mock.new
    @driver_provider.expect(:make, @driver)
    @subject = Model.new
    @subject.driver_provider = @driver_provider
  end

  def test_model_train_generates_a_driver_model_for_each_driver_command
    @driver2 = Minitest::Mock.new
    @driver2.expect(:name=, nil, ['Alex'])

    @driver_provider.expect(:make, @driver2)

    @subject.train('Driver Dan\nDriver Alex')

    assert_mock @driver_provider
    assert_mock @driver
    assert_mock @driver2
  end

  def test_model_train_adds_a_trip_to_appropriate_driver_for_trip_command
    configure_trip_mock

    @subject.trip_provider = @trip_provider

    @subject.train('Driver Dan\nTrip Dan 07:15 07:45 17.3')

    assert_mock @driver_provider
    assert_mock @driver
    assert_mock @trip_provider
    assert_mock @trip
  end

  private

  def configure_trip_mock
    @trip = Minitest::Mock.new
    @trip.expect(:configure, nil, ['Dan', Time.parse('07:15'),
                                   Time.parse('07:45'), 17.3])
    @driver.expect(:add_trip, nil, [@trip])

    @trip_provider = Minitest::Mock.new
    @trip_provider.expect(:make, @trip)
  end
end
