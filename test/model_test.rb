require 'minitest/autorun'
require_relative '../lib/driver.rb'

class ModelTest < Minitest::Test
  def test_model_train_generates_a_driver_model_when_given_a_driver_command
    subject = Model.new
    subject.train('Driver Dan')

    assert_equal(subject.drivers, [Driver.new('Dan')])
  end
end
