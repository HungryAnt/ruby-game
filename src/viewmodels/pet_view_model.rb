class PetViewModel
  def initialize(pet)
    @pet = pet
    init_animations
  end

  def x
    @pet.x
  end

  def y
    @pet.y
  end

  def set_destination(target_x, target_y)
    @pet.set_auto_move_to target_x, target_y
  end

  def auto_move(area)
    @pet.auto_move area
  end

  def move_random

  end

  def move_to_owner

  end

  def attack

  end

  def sleep

  end

  def cute

  end

  def change_action

  end

  def draw
    draw_anim
  end

  private

  def init_animations
    pet_type = @pet.pet_type.to_s
    Pet::State::ALL_STATES.each do |state|
      %w(left right up down).each do |direction|
        self.instance_variable_set(
            "@anim_#{state}_#{direction}",
            AnimationManager.get_anim("#{pet_type}_#{state}_#{direction}".to_sym))
      end
    end
    @current_anim = @anim_stand_down
    anim_goto_begin
  end

  def draw_anim
    x, y = get_actual_pet_location
    @current_anim.draw(x, y, ZOrder::Player, init_timestamp:@anim_init_timestamp)
  end

  def anim_goto_begin
    @anim_init_timestamp = Gosu::milliseconds
  end

  def get_actual_pet_location
    [@pet.x, @pet.y - 20]
  end

end