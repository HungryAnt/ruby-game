class AreaViewModel
  attr_reader :image, :area, :item_vms

  def initialize(area)
    autowired(SongService)
    @area = area
    @image = MediaUtil::get_tileable_img(@area.image_path)
    @scale_x = GameConfig::MAP_WIDTH * 1.0 / @image.width
    @scale_y = GameConfig::MAP_HEIGHT * 1.0 / @image.height
    @anim_container = AnimationContainer.new
    @item_vms = []
    @large_rubbish_vms = []
    init_covering
    @mutex = Mutex.new
    init_large_rubbish
  end

  def init_large_rubbish
    large_rubbish = LargeRubbish.new 'id', 400, 300, 8, 1000, 800
    large_rubbish_vm = LargeRubbishViewModel.new(large_rubbish)
    @large_rubbish_vms << large_rubbish_vm
  end

  def init_covering
    @covering_views = []
    @area.coverings.each do |covering|
      if covering.include? :image_path
        visual = MediaUtil::get_tileable_img(covering[:image_path])
      else
        visual = AnimationManager.get_anim covering[:anim]
      end
      covering_view = {
        :visual => visual,
        :x => covering[:x] * @scale_x,
        :y => covering[:y] * @scale_y
      }
      covering_view[:zorder] = covering[:zorder] == :over ? ZOrder::Covering : ZOrder::Background
      @covering_views << covering_view
    end
  end

  def id
    @area.id
  end

  def tiles
    @area.tiles
  end

  def update
    @anim_container.update
  end

  def draw
    @image.draw(0, 0, ZOrder::Background, @scale_x, @scale_y)
    @anim_container.draw
    draw_covering
  end

  def activate
    if @area.song_path.nil?
      @song_service.stop_song
    else
      @song_service.play_song @area.song_path
    end
  end

  def mark_target(x, y)
    anim = AnimationManager::get_anim :area_click
    anim_holder = AnimationHolder.new anim, x, y, ZOrder::Background, false, 1
    @anim_container.add_anim anim_holder
  end

  def tile_block?(x, y)
    @area.tile_block? x, y
  end

  def random_available_position
    @area.random_available_position
  end

  def get_item_vms
    @item_vms
  end

  def add_item_vm(item_vm)
    @mutex.synchronize {
      @item_vms << item_vm
    }
  end

  def delete_item_vm(item_id)
    @mutex.synchronize {
      @item_vms = @item_vms.reject {|item_vm| item_vm.id == item_id}
    }
  end

  def clear_item_vms
    @mutex.synchronize {
      @item_vms = []
    }
  end

  def get_large_rubbish_vms
    @large_rubbish_vms
  end

  def add_large_rubbish_vms(large_rubbish_vm)
    @mutex.synchronize {
      @large_rubbish_vms << large_rubbish_vm
    }
  end

  def clear_large_rubbish_vms
    @mutex.synchronize {
      @large_rubbish_vms = []
    }
  end

  private
  def draw_covering
    @covering_views.each do |covering_view|
      covering_view[:visual].draw(covering_view[:x], covering_view[:y], covering_view[:zorder])
    end
  end
end