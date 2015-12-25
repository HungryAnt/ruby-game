class AreaViewModel
  attr_reader :image, :area, :item_vms, :visual_element_vms, :additional_equipment_vm

  def initialize(area)
    autowired(SongService)
    @area = area
    @image = MediaUtil::get_tileable_img(@area.image_path)
    @scale_x = GameConfig::MAP_WIDTH * 1.0 / @image.width
    @scale_y = GameConfig::MAP_HEIGHT * 1.0 / @image.height
    @anim_container = AnimationContainer.new
    @item_vms = []
    @large_rubbish_vms = []
    @monster_vms = []
    init_covering
    init_visual_elements
    init_additional_equipment
    @mutex = Mutex.new
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

  def init_visual_elements
    @visual_element_vms = []
    @area.visual_elements.each do |element|
      @visual_element_vms << AreaVisualElementViewModel.new(element)
    end
  end

  def init_additional_equipment
    @additional_equipment_vm = nil
    return if @area.additional_equipment.nil?
    @additional_equipment_vm = EquipmentViewModelFactory.create_equipment_from_key(
        Equipment::Type::AREA_ADDITION, @area.additional_equipment)
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
    @mutex.synchronize {
      return @large_rubbish_vms
    }
  end

  def add_large_rubbish_vm(large_rubbish_vm)
    @mutex.synchronize {
      @large_rubbish_vms << large_rubbish_vm
    }
  end

  def update_large_rubbish_vm(large_rubbish_vm)
    @mutex.synchronize {
      target_vm = @large_rubbish_vms.find {|item| item.id == large_rubbish_vm.id}
      if target_vm.nil?
        @large_rubbish_vms << large_rubbish_vm
      else
        target_vm.update_large_rubbish large_rubbish_vm.large_rubbish
      end
    }
  end

  def destroy_large_rubbish_vm(id)
    @mutex.synchronize {
      @large_rubbish_vms.delete_if {|item| item.id == id}
    }
  end

  def clear_enemy_vms
    @mutex.synchronize {
      @large_rubbish_vms = []
      @monster_vms = []
    }
  end

  def get_monster_vms
    @mutex.synchronize {
      return @monster_vms
    }
  end

  def add_monster_vm(monster_vm)
    @mutex.synchronize {
      @monster_vms << monster_vm
    }
  end

  def update_monster_vm(monster_vm)
    @mutex.synchronize {
      target_vm = @monster_vms.find {|item| item.id == monster_vm.id}
      if target_vm.nil?
        @monster_vms << monster_vm
      else
        target_vm.update_monster monster_vm.monster
      end
    }
  end

  def update_monster_hp(monster)
    find_monster_and(monster.id) { |target_vm| target_vm.update_hp monster.hp }
  end

  def destroy_monster_vm(id)
    @mutex.synchronize {
      @monster_vms.delete_if {|item| item.id == id}
    }
  end

  def monster_move_to(monster_id, x, y)
    find_monster_and(monster_id) { |target_vm| target_vm.move_to(x, y) }
  end

  def monster_attack(monster_id)
    find_monster_and(monster_id) { |target_vm| target_vm.attack }
  end

  def clear_monster_vms
    @mutex.synchronize {
      @monster_vms = []
    }
  end

  private

  def find_monster_and(monster_id)
    @mutex.synchronize {
      target_vm = @monster_vms.find {|item| item.id == monster_id}
      yield target_vm unless target_vm.nil?
    }
  end

  def draw_covering
    @covering_views.each do |covering_view|
      covering_view[:visual].draw(covering_view[:x], covering_view[:y], covering_view[:zorder])
    end
  end
end