class PreciseStrike
  DAMAGE_BASIC_MOD = 1.2
  DAMAGE_LVL_MOD = 0.1
  ACCURACY_BASIC_MOD = 1.5
  ACCURACY_LVL_MOD = 0.1
  MP_COST = 8

  attr_accessor :lvl
  attr_reader :code, :name
  attr_accessor :mp_cost

  def initialize
    @code = 'precise_strike'
    @name = "Precise strike"
    @lvl = 0
    @mp_cost = MP_COST
  end

  def damage_mod
    DAMAGE_BASIC_MOD + DAMAGE_LVL_MOD * @lvl
  end

  def accuracy_mod
    ACCURACY_BASIC_MOD + ACCURACY_LVL_MOD * @lvl
  end

  def description
    "(#{@lvl}): more precisely in #{accuracy_mod().round(1)}, stronger in #{damage_mod().round(1)}. Cost #{MP_COST}"
  end

  def description_short
    "More precisely in #{accuracy_mod().round(1)}, stronger in #{damage_mod().round(1)}. Cost #{MP_COST}"
  end
end










#
