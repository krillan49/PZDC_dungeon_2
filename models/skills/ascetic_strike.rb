class AsceticStrike
  DAMAGE_BASIC_MOD = 1
  ACCURACY_BASIC_MOD = 1
  DAMAGE_LVL_MOD = 0.01
  ACCURACY_LVL_MOD = 0.01
  MP_COST = 5

  attr_accessor :lvl
  attr_reader :code, :name
  attr_accessor :mp_cost

  def initialize(hero)
    @code = 'ascetic_strike'
    @name = "Ascetic strike"
    @lvl = 0
    @mp_cost = MP_COST

    @hero = hero
  end

  def damage_mod
    DAMAGE_BASIC_MOD + DAMAGE_LVL_MOD * @lvl * @hero.stat_points
  end

  def accuracy_mod
    ACCURACY_BASIC_MOD + ACCURACY_LVL_MOD * @lvl * @hero.stat_points
  end

  def show_cost
    "#{MP_COST} MP"
  end

  def description
    "Free stat points #{@hero.stat_points} precisely in #{accuracy_mod().round(1)}, damage more in #{damage_mod().round(1)}"
  end

  def description_short
    "Cost #{MP_COST}. The more free stat points - the more damage and accuracy"
  end
end









#
