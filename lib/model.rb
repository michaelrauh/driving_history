# Top level model for data domain
class Model
  attr_accessor :drivers

  def initialize
    @drivers = []
  end

  def train(description)
    lines = description.split('\n')
    lines.each do |line|
      tokens = line.split(' ')
      tokens.shift
      drivers << Driver.new(tokens.shift)
    end
  end
end
