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
end
