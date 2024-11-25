class TraumaticStrike
  DAMAGE_MOD = 1
  ACCURACY_MOD = 1
  EFFECT_BASIC_MOD = 20
  EFFECT_LVL_MOD = 3
  MP_COST = 6

  attr_accessor :lvl
  attr_reader :code, :name
  attr_accessor :mp_cost

  def initialize
    @code = 'traumatic_strike'
    @name = "Traumatic strike"
    @lvl = 0
    @mp_cost = MP_COST
  end

  def damage_mod
    DAMAGE_MOD
  end

  def accuracy_mod
    ACCURACY_MOD
  end

  def effect
    EFFECT_BASIC_MOD + EFFECT_LVL_MOD * @lvl
  end

  def effect_coef
    (100 - effect()) / 100.0
  end

  def show_cost
    "#{MP_COST} MP"
  end

  def description
    "Attack reduces enemy damage by #{effect()}%"
  end

  def description_short
    "Cost #{MP_COST}. Attack reduces enemy damage by some %"
  end
end











#
