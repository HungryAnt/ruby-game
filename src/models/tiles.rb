module Tiles
  NONE = ' ' # 空旷区 可移动
  BLOCK = '#' # 禁止移动区
  INIT_POSITION = 'X' # 认为出现在地图中的初始位置
  GATEWAY = 'A' # 传送

  def self.color(tile)
    return 0x88_00FF00 if tile == Tiles::NONE
    return 0x88_444444 if tile == Tiles::BLOCK
    return 0x88_FFFFFF if tile == Tiles::INIT_POSITION
    return 0x88_0000FF if gateway?(tile)
    return 0x88_FF0000
  end

  @@gateways = ('1'..'9').to_a + ('A'..'Z').to_a

  def self.gateway?(tile)
    @@gateways.include? tile
  end
end