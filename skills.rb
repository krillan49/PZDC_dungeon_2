class StrongStrike
  DAMAGE_BASIC_MOD = 2
  DAMAGE_LVL_MOD = 0.2
  ACCURACY_MOD = 1

  attr_accessor :lvl, :mp_cost
  attr_reader :name

  def initialize
    @name = "Сильный удар"
    @lvl = 0
    @mp_cost = 15
  end

  def damage_mod
    DAMAGE_BASIC_MOD + DAMAGE_LVL_MOD * @lvl
  end

  def accuracy_mod
    ACCURACY_MOD
  end

  def description
    "(#{@lvl}): урон сильнее в #{damage_mod().round(1)}, наносится по телу. Цена #{@mp_cost}"
  end
end


class PreciseStrike
  DAMAGE_BASIC_MOD = 1
  DAMAGE_LVL_MOD = 0.1
  ACCURACY_BASIC_MOD = 1.5
  ACCURACY_LVL_MOD = 0.1


  attr_accessor :lvl, :mp_cost
  attr_reader :name

  def initialize
    @name = "Точный удар"
    @lvl = 0
    @mp_cost = 5
  end

  def damage_mod
    DAMAGE_BASIC_MOD + DAMAGE_LVL_MOD * @lvl
  end

  def accuracy_mod
    ACCURACY_BASIC_MOD + ACCURACY_LVL_MOD * @lvl
  end

  def description
    "(#{@lvl}): точнее в #{accuracy_mod().round(1)}, сильнее в #{damage_mod().round(1)} наносится по телу. Цена #{@mp_cost}"
  end
end

# [StrongStrike.new, PreciseStrike.new].each do |n|
#   p n
#   p n.accuracy_mod
#   p n.description
#   n.lvl += 3
#   p n
#   p n.accuracy_mod
#   p n.description
#   p '--------------------'
# end












#
