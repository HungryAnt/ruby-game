
#$:.unshift(File.join(File.dirname(__FILE__), '..', 'src'))
#$:.unshift(File.dirname(__FILE__).gsub '/test', '/src')

require '../test_help'
require 'test/unit'
require 'core/player'

class PlayerTest < Test::Unit::TestCase

  def setup
  end

  def teardown

  end

  def test_player
    player = Player.new
    player.name = 'Ant'
    assert_equal('Ant', player.name)
    assert_equal(0, player.level)
  end

  def test_player_level_up
    player = Player.new
    0.upto(10).each do |i|
      assert_equal(i, player.level)
      player.level_up
    end
  end
end