module Tiles
  NONE = ' ' # �տ��� ���ƶ�
  BLOCK = '#' # ��ֹ�ƶ���
  GATEWAY = -2 # ����

  def self.color(tile)
    return 0x88_00FF00 if tile == Tiles::NONE
    return 0x88_444444 if tile == Tiles::BLOCK
    return 0x88_0000FF if gateway?(tile)
    return 0x88_FF0000
  end

  @@gateways = ('1'..'9').to_a + ('A'..'Z').to_a

  def self.gateway?(tile)
    @@gateways.include? tile
  end
end