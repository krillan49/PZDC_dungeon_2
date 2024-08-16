class StrongStrike
  DAMAGE_BASIC_MOD = 1.6
  DAMAGE_LVL_MOD = 0.2
  ACCURACY_MOD = 1
  MP_COST = 10

  attr_accessor :lvl
  attr_reader :code, :name
  attr_accessor :mp_cost

  def initialize
    @code = 'strong_strike'
    @name = "Strong strike"
    @lvl = 0
    @mp_cost = MP_COST
  end

  def damage_mod
    DAMAGE_BASIC_MOD + DAMAGE_LVL_MOD * @lvl
  end

  def accuracy_mod
    ACCURACY_MOD
  end

  def description
    "(#{@lvl}): damage is stronger in #{damage_mod().round(1)}. Cost #{MP_COST}"
  end
end











#
