class TryPickupItemMessage
  attr_reader :user_id, :area_id, :item_id

  def initialize(user_id, area_id, item_id)
    @user_id = user_id
    @area_id = area_id
    @item_id = item_id
  end

  def to_json(*a)
    {
        type: 'try_pickup_item_message',
        data: {user_id: @user_id, area_id: @area_id, item_id: @item_id}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['user_id'], map['data']['area_id'], map['data']['item_id'])
  end
end