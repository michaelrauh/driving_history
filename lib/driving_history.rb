require_relative '../wrapper/command_line.rb'

# Takes in a filename and produces a driving report
class DrivingHistory
  attr_accessor :command_line

  def initialize
    @command_line = CommandLine.new
  end

  def run
    @command_line.args_array
  end
end
