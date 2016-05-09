# coding: UTF-8

class PetUnionView < ViewBase
  def initialize(window)
    super
    autowired(WindowResourceService, AccountService, UserService, PlayerService)
    init_ui
  end

  def init_ui
    @background = Image.new(MediaUtil.get_img 'pet_union_room/PetUinonRoom_0.png')
    @anim_pet_union_button_press = AnimationManager.get_anim :pet_union_button_press
    @pet_union_spirit_0 = AnimationManager.get_anim :pet_union_spirit_0
    @pet_union_spirit_1 = AnimationManager.get_anim :pet_union_spirit_1
    @pet_union_spirit_2 = AnimationManager.get_anim :pet_union_spirit_2
    @pet_union_big_frog_open_mouth = AnimationManager.get_anim :pet_union_big_frog_open_mouth
    @pet_union_big_frog = AnimationManager.get_anim :pet_union_big_frog
    @pet_union_button_line = AnimationManager.get_anim :pet_union_button_line
    @pet_union_spirit_3 = AnimationManager.get_anim :pet_union_spirit_3
  end

  def update

  end

  def draw
    z = ZOrder::Background
    @background.draw(0, 0, z)
    @anim_pet_union_button_press.draw(300, 430, z)
    @pet_union_spirit_0.draw(250, 450, z)
    @pet_union_spirit_1.draw(0, 220, z)

    # @pet_union_spirit_2.draw(, , z)
    @pet_union_big_frog.draw(0, 70, z)
    @pet_union_button_line.draw(420, 375, z)
    @pet_union_spirit_3.draw(424, 306, z)
  end

  def button_down(id)

  end

  def button_up(id)

  end
end