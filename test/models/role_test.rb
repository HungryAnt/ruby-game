require_relative '../test_help'
require 'test/unit'
require 'models/role'

class RoleTest < Test::Unit::TestCase
  def setup
    @player = Role.new(100, 100)
  end

  def teardown
    # Do nothing
  end

  def test_player_hp
    assert_equal(100, @player.hp)
    assert_equal(100, @player.max_hp)
  end

  def test_player_hp_change
    @player.inc_hp 10
    assert_equal(100, @player.hp) # ����������Ϊֹ
    @player.dec_hp 20
    assert_equal(80, @player.hp)
    @player.dec_hp 50
    assert_equal(30, @player.hp)
    @player.dec_hp 50
    assert_equal(0, @player.hp) # ������0Ϊֹ
  end

  def test_player_exp
    assert_equal(0, @player.exp)
    assert_equal(100, @player.max_exp)
    assert_equal(1, @player.lv)
  end

  def test_player_exp_inc
    # ����50�㾭��
    @player.inc_exp 50
    assert_equal(50, @player.exp)
    assert_equal(100, @player.max_exp)
    assert_equal(1, @player.lv)

    # ����ӵ�110������
    @player.inc_exp 60
    assert_equal(10, @player.exp)
    assert_equal(200, @player.max_exp)
    assert_equal(2, @player.lv)

    # ����ӵ�310������
    @player.inc_exp 200
    assert_equal(10, @player.exp)
    assert_equal(300, @player.max_exp)
    assert_equal(3, @player.lv)
  end
end