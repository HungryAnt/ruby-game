require_relative 'nutrient_type_info'

class NutrientBin
  def initialize
    init
  end

  def init
    @nutrients = []
    0.upto(NutrientTypeInfo::COUNT - 1) do
      @nutrients << 0
    end
  end

  def update(nutrients)
    0.upto(NutrientTypeInfo::COUNT - 1) do |i|
      @nutrients[i] = nutrients[i]
    end
  end

  def inc(nutrient_id)
    @nutrients[nutrient_id] += 1
  end

  def get(nutrient_id)
    @nutrients[nutrient_id]
  end

  def get_nutrients
    nutrients_data = []
    @nutrients.each_with_index do |count, i|
      if count > 0
        nutrients_data << {
            nutrient_type_id: i,
            count: count
        }
      end
    end
    nutrients_data
  end
end