require_relative '../wrapper/command_line.rb'
require_relative '../wrapper/file_helper.rb'
require_relative 'model.rb'

# Takes in a filename and produces a driving report
class DrivingHistory
  attr_accessor :command_line
  attr_accessor :file_helper
  attr_accessor :model

  def initialize
    @command_line = CommandLine.new
    @file_helper = FileHelper.new
    @model = Model.new
  end

  def run
    filename = @command_line.args_array.first
    file_contents = @file_helper.read(filename)
    @model.train(file_contents)
    @model.report
  end
end
