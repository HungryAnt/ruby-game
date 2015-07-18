module Tiles
  NONE = ' ' # �տ��� ���ƶ�
  BLOCK = '#' # ��ֹ�ƶ���
  GATEWAY = -2 # ����

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