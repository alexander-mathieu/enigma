require './test/test_helper'
require './lib/offset_generator'

class OffsetGeneratorTest < MiniTest::Test

  def setup
    @offset_generator = OffsetGenerator.new
  end

  def test_it_exists
    assert_instance_of OffsetGenerator, @offset_generator
  end

  def test_by_default_it_has_a_date
    assert_equal "041219", @offset_generator.date
  end

  def test_it_can_turn_the_date_into_an_integer
    assert_equal 41219, @offset_generator.date_to_integer
  end

  def test_it_can_square_the_date
    assert_equal 1699005961, @offset_generator.square_date
  end

end