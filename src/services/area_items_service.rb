class AreaItemsService
  def initialize
    @item_msg_callback = nil
  end

  def register_item_msg_callback(&item_msg_callback)
    @item_msg_callback = item_msg_callback
  end

  def add_item_msg(area_item_msg)
    @item_msg_callback.call area_item_msg
  end
end