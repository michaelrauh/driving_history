require 'minitest/autorun'
require_relative '../lib/driving_history.rb'
require_relative '../wrapper/command_line.rb'

class DrivingHistoryTest < Minitest::Test
  def setup
    @command_line = Minitest::Mock.new
    @command_line.expect :args_array, ['foo.rb']

    @subject = DrivingHistory.new

    @subject.command_line = @command_line
  end

  def test_run_method_reads_in_command_line_arguments
    @subject.run
    assert_mock @command_line
  end
end
