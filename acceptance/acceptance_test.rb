require 'minitest/autorun'

# Test top level functionality according to contract
class AcceptanceTest < Minitest::Test
  def test_generated_output_matches_example
    assert system 'acceptance/acceptance_test.sh'
  end
end
