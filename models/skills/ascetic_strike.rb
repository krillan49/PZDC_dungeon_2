class AsceticStrike
  DAMAGE_BASIC_MOD = 1
  ACCURACY_BASIC_MOD = 1
  DAMAGE_LVL_MOD = 0.007
  ACCURACY_LVL_MOD = 0.007
  MP_COST = 2

  attr_accessor :lvl
  attr_reader :entity_type, :code, :name
  attr_accessor :mp_cost

  def initialize(hero)
    @entity_type = 'skills'
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

  def show_accuracy
    ((accuracy_mod() - 1) * 100).round
  end

  def show_damage
    ((damage_mod() - 1) * 100).round
  end

  def description
    "Free stat points #{@hero.stat_points}. Additional damage +#{show_damage()}%. Additional accuracy +#{show_accuracy()}%"
  end

  def description_short
    "Cost #{MP_COST}. The more free stat points - the more damage and accuracy"
  end
end









#
