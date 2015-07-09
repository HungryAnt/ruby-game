$:.unshift(File.join(File.dirname(__FILE__), '..', 'src'))
require 'test/unit'
require 'game_package'

class GamePackageTest < Test::Unit::TestCase

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

  def test_package_init
    package = GamePackage.new(3)
    assert_not_nil package.items
    assert_equal(0, package.items.length)
    assert_equal(3, package.capacity)
  end

  def test_add_item
    package = GamePackage.new(3)
    package.add("xx1")
    package << "xx2"
    package.add("xx3")
    assert_equal(3, package.items.length)
  end

  def test_get_item
    package = GamePackage.new(3)
    package[0] = "xx2"
    assert_equal("xx2", package[0])
  end
end