require 'minitest/autorun'
require 'time'
require_relative '../lib/trip.rb'

class TripTest < Minitest::Test
  def setup
    @subject = Trip.new
  end

  def test_configuring_a_valid_trip_results_in_correct_miles
    @subject.configure(Time.parse('07:15'), Time.parse('07:45'), 17.3)
    assert_equal(17.3, @subject.miles)
  end

  def test_configuring_a_valid_trip_results_in_valid
    @subject.configure(Time.parse('07:15'), Time.parse('07:45'), 17.3)
    assert(@subject.valid?)
  end

  def test_configuring_a_valid_trip_results_in_correct_speed
    @subject.configure(Time.parse('07:15'), Time.parse('07:45'), 17.3)
    assert_equal(34.6, @subject.speed)
  end

  def test_configuring_a_trip_with_speed_less_than_five_is_invalid
    @subject.configure(Time.parse('01:15'), Time.parse('22:45'), 10.1)

    assert(!@subject.valid?)
  end

  def test_configuring_a_trip_with_speed_greater_than_one_hundred_is_invalid
    @subject.configure(Time.parse('01:15'), Time.parse('01:16'), 9000.1)

    assert(!@subject.valid?)
  end
end
