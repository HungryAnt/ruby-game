require_relative '../test_help'
require 'test/unit'
require 'engine/animation_util'

class AnimationUtilTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_get_path
    path = AnimationUtil::get_path 'role/wangye/WanGye_#{num}.bmp', 10
    assert_equal('role/wangye/WanGye_10.bmp', path)
  end
end