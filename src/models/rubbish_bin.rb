require_relative 'rubbish_type_info'

class RubbishBin
  def initialize
    init
  end

  def init
    @rubbishes = []
    0.upto(RubbishTypeInfo::COUNT - 1) do
      @rubbishes << 0
    end
  end

  def clear
    init
  end

  def update(rubbishes)
    0.upto(RubbishTypeInfo::COUNT - 1) do |i|
      @rubbishes[i] = rubbishes[i]
    end
  end

  def inc(rubbish_id)
    @rubbishes[rubbish_id] += 1
  end

  def get(rubbish_id)
    @rubbishes[rubbish_id]
  end

  def get_rubbishes
    rubbishes_data = []
    @rubbishes.each_with_index do |count, i|
      if count > 0
        rubbishes_data << {
            rubbish_type_id: i,
            count: count
        }
      end
    end
    rubbishes_data
  end
end