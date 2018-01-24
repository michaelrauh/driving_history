# Top level model for data domain
class Model
  attr_accessor :drivers

  def initialize
    @drivers = []
  end

  def train(description)
    tokens = description.split(' ')
    tokens.shift
    drivers << Driver.new(tokens.shift)
  end
end
