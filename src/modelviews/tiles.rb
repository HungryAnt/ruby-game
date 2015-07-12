module Tiles
  None = 0 # 空旷区 可移动
  Block = 1 # 禁止移动区
  Gateway = 2 # 传送

  def self.color(tile)
    case tile
      when Tiles::None
        0x88_00FF00
      when Tiles::Block
        0x88_444444
      when Tiles::Gateway
        0x88_0000FF
    end
  end
end