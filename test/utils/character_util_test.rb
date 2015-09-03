# coding: UTF-8

require_relative '../test_help'
require 'test/unit'
require 'utils/character_util'

class CharacterUtilTest < Test::Unit::TestCase

  def test_is_cjk_char
    '中文'.each_char do |char|
      assert(CharacterUtil.is_cjk_char char)
    end

    '123'.each_char do |char|
      assert_false(CharacterUtil.is_cjk_char char)
    end
  end
end