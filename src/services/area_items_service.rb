class AreaItemsService
  def initialize
    @mutex = Mutex.new
    @item_msg_call_back = nil
  end

  def register_item_msg_callback(&item_msg_call_back)
    @item_msg_call_back = item_msg_call_back
  end

  def add_item_msg(area_item_msg)
    @item_msg_call_back.call area_item_msg
  end
end