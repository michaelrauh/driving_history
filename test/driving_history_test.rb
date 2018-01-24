require 'minitest/autorun'
require_relative '../lib/driving_history.rb'
require_relative '../wrapper/command_line.rb'

class DrivingHistoryTest < Minitest::Test
  def setup
    @command_line = Minitest::Mock.new
    @command_line.expect :args_array, ['foo.rb']

    @file_helper = Minitest::Mock.new
    @file_helper.expect :read, 'this is a file with words', ['foo.rb']

    @model = Minitest::Mock.new
    @model.expect :train, nil, ['this is a file with words']

    @subject = DrivingHistory.new

    @subject.command_line = @command_line
    @subject.file_helper = @file_helper
    @subject.model = @model
  end

  def test_run_method_reads_in_command_line_arguments
    @subject.run
    assert_mock @command_line
  end

  def test_run_method_opens_file_according_to_name_passed
    @subject.run
    assert_mock @file_helper
  end

  def test_run_method_builds_a_model_from_file_contents
    @subject.run
    assert_mock @model
  end
end
