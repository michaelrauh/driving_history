require 'minitest/autorun'

class ModelTest < Minitest::Test
  def setup
    @driver = Minitest::Mock.new
    @driver.expect(:name=, nil, ['Dan'])
    @driver2 = Minitest::Mock.new
    @driver2.expect(:name=, nil, ['Alex'])

    @driver_provider = Minitest::Mock.new
    @driver_provider.expect(:make, @driver)
    @driver_provider.expect(:make, @driver2)

    @subject = Model.new
    @subject.driver_provider = @driver_provider
  end

  def test_model_train_generates_a_driver_model_for_each_driver_command
    @subject.train('Driver Dan\nDriver Alex')

    assert_mock @driver_provider
    assert_mock @driver
    assert_mock @driver2
  end
end
