# coding: UTF-8

class PlayerService
  attr_reader :player

  def initialize
    @player = Role.new('终极帅哥sl', RoleType::WAN_GYE, 100, 300)
  end
end