module Tiles
  NONE = ' ' # 空旷区 可移动
  BLOCK = '#' # 禁止移动区
  GATEWAY = -2 # 传送

  def self.color(tile)
    case tile
      when Tiles::NONE
        0x88_00FF00
      when Tiles::BLOCK
        0x88_444444
      when Tiles::GATEWAY
        0x88_0000FF
    end
  end

  @@gateways = (1..9).to_a + ('A'..'Z').to_a

  def self.gateway?(tile)
    @@gateways.include? tile
  end
end