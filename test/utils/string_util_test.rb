# coding: UTF-8

require_relative '../test_help'
require 'test/unit'
require 'utils/string_util'

class StringUtilTest < Test::Unit::TestCase
  def test_split_lines
    lines = StringUtil.split_lines('12345', 3)
    assert_equal(2, lines.size)
    assert_equal('123', lines[0])
    assert_equal('45', lines[1])

    lines = StringUtil.split_lines('Ant版野菜部落', 3)
    assert_equal(6, lines.size)
    assert_equal('Ant', lines[0])
    assert_equal('版', lines[1])
    assert_equal('野', lines[2])
    assert_equal('菜', lines[3])
    assert_equal('部', lines[4])
    assert_equal('落', lines[5])

    lines = StringUtil.split_lines('Ant版野菜部落', 12)
    assert_equal(2, lines.size)
    assert_equal('Ant版野菜部', lines[0])
    assert_equal('落', lines[1])
  end

  def test_camel_to_underline
    assert_equal 'abc123', StringUtil.camel_to_underline('Abc123')
    assert_equal 'abc_a123', StringUtil.camel_to_underline('AbcA123')
    assert_equal 'aa_bb_cc_dd_ee', StringUtil.camel_to_underline('AaBbCcDdEe')
    assert_equal 'eye_wear', StringUtil.camel_to_underline('EyeWear')
  end

  def test_underline_to_camel
    assert_equal 'Abc123', StringUtil.underline_to_camel('abc123')
    assert_equal 'AbcA123', StringUtil.underline_to_camel('abc_a123')
    assert_equal 'AaBbCcDdEe', StringUtil.underline_to_camel('aa_bb_cc_dd_ee')
    assert_equal 'EyeWear', StringUtil.underline_to_camel('eye_wear')
  end
end