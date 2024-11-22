class PreciseStrike
  DAMAGE_BASIC_MOD = 1.1
  DAMAGE_LVL_MOD = 0.05
  ACCURACY_BASIC_MOD = 1.3
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

  def show_cost
    "#{MP_COST} MP"
  end

  def description
    "More precisely in #{accuracy_mod().round(1)}, stronger in #{damage_mod().round(1)}"
  end

  def description_short
    "Cost #{MP_COST}. Attack much more accurately and a little stronger"
  end
end










#
