class AnimationContainer
  def initialize
    @anims = []
  end

  def add_anim anim
    @anims << anim
  end

  def << anim
    add_anim anim
  end

  def update
    @anims.reject! {|anim| anim.finish?}
  end

  def draw(options={})
    @anims.each do |anim|
      anim.draw options
    end
  end
end