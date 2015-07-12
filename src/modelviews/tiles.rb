module Tiles
  None = 0 # �տ��� ���ƶ�
  Block = 1 # ��ֹ�ƶ���
  Gateway = 2 # ����

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