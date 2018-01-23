require 'minitest/autorun'
require_relative '../lib/driving_history.rb'

class DrivingHistoryTest < Minitest::Test
  def setup
    @subject = DrivingHistory.new
  end
end
