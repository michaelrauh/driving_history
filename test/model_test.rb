require 'minitest/autorun'
require_relative '../lib/driver.rb'

class ModelTest < Minitest::Test
  def setup
    @subject = Model.new
  end

  def test_model_train_generates_a_driver_model_when_given_a_driver_command
    @subject.train('Driver Dan')

    assert_equal(@subject.drivers, [Driver.new('Dan')])
  end

  def test_model_train_generates_a_driver_for_each_driver_command
    @subject.train('Driver Dan\nDriver Alex')

    assert_equal(@subject.drivers, [Driver.new('Dan'), Driver.new('Alex')])
  end
end
