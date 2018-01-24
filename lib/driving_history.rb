require_relative '../wrapper/command_line.rb'
require_relative '../wrapper/file_helper.rb'

# Takes in a filename and produces a driving report
class DrivingHistory
  attr_accessor :command_line
  attr_accessor :file_helper

  def initialize
    @command_line = CommandLine.new
    @file_helper = FileHelper.new
  end

  def run
    filename = @command_line.args_array.first
    @file_helper.read(filename)
  end
end
