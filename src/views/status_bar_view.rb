class StatusBarView
  def initialize
    @img = MediaUtil::get_tileable_img('ui/status_bar.bmp')
  end

  def update

  end

  def draw
    @img.draw(0, 0, ZOrder::UI)
  end
end