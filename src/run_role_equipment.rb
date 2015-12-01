# coding: UTF-8
$:.unshift(File.dirname(__FILE__))
@base_src_dir = File.dirname(__FILE__)

require 'gosu'

require 'utils/media_util'
MediaUtil.init_base_media_path(File.join(Dir::pwd, '../media'))

require 'z_order'
require 'engine/image'
require 'engine/direction'
require 'engine/animation'
require 'engine/animation_holder'
require 'engine/animation_container'
require 'engine/animation_util'
require 'engine/animation_manager'

require 'models/location'
require 'models/role_type'

require 'services/equipment_definition'
require 'config/anim_config'
require 'config/equipment_config'
require 'config/equipment_vehicle_config'
require 'config/equipment_eye_wear_config'

class Role
  include Location

  def initialize(type, name)
    @type, @name = type, name
    @image = get_image
  end

  def draw
    dx, dy = x, y - 30
    @image.draw_rot(dx, dy, ZOrder::Player, 0, 0.5, 0.5, 1, 1)
  end

  private

  def get_image
    image_path = "role/#{@type.to_s}/#{@name}_0.bmp"
    MediaUtil.get_img image_path
  end
end

class RoleEquipmentWindow < Gosu::Window
  WINDOW_WIDTH = 80 * 12
  WINDOW_HEIGHT = 200

  def initialize
    super WINDOW_WIDTH, 200, fullscreen:false, update_interval:1000/40
    self.caption = 'Ant版野菜部落 饰品调试器'
    @roles = get_roles
  end

  def update

  end

  def draw
    Gosu::draw_rect 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, 0xFF_446560, ZOrder::Background
    @roles.each do |role|
      role.draw
    end
  end

  def button_down(id)
    case id
      when Gosu::KbF1
        @current_view = @game_map_view
      when Gosu::KbF3
        @current_view = @map_editor_view
    end
  end

  def needs_cursor?
    true
  end

  private

  def get_roles
    role_info_list = []
    role_info_list << [RoleType::WAN_GYE, 'WanGye']
    role_info_list << [RoleType::SALARY, 'Salary']
    role_info_list << [RoleType::BANGYE, 'BanGye']
    role_info_list << [RoleType::DOOBU, 'Doobu']
    role_info_list << [RoleType::KIMCHI, 'Kimchi']
    role_info_list << [RoleType::MANL, 'Manl']
    role_info_list << [RoleType::MOO, 'Moo']
    role_info_list << [RoleType::PASERY, 'Pasery']
    role_info_list << [RoleType::PIMENTO, 'Pimento']
    role_info_list << [RoleType::RICE, 'Rice']
    role_info_list << [RoleType::YANGBEA, 'Yangbea']
    role_info_list << [RoleType::YANGPA, 'Yangpa']

    x = 40
    y = 40 + 30
    role_info_list.map do |role_info|
      role = Role.new(role_info[0], role_info[1])
      role.x = x
      role.y = y
      x += 80
      role
    end
  end
end

RoleEquipmentWindow.new.show