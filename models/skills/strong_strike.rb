class StrongStrike
  DAMAGE_BASIC_MOD = 2
  DAMAGE_LVL_MOD = 0.2
  ACCURACY_MOD = 1

  attr_accessor :lvl
  attr_reader :code, :name
  attr_accessor :mp_cost

  def initialize
    @code = 'strong_strike'
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











#
