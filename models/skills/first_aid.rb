class FirstAid
  HEAL_BASIC_MOD = 1
  HEAL_LVL_MOD = 0.1
  HERO_HP_MOD = 0.2

  attr_accessor :lvl
  attr_reader :code, :name
  attr_accessor :mp_cost
  attr_reader :hero

  def initialize(hero)
    @code = 'first_aid'
    @name = "First aid"
    @lvl = 0
    @mp_cost = 10

    @hero = hero
  end

  def coeff_lvl
    HEAL_BASIC_MOD + HEAL_LVL_MOD * @lvl
  end

  def heal_effect
    (@hero.hp_max - @hero.hp) * HERO_HP_MOD * coeff_lvl()
  end

  def description
    "(#{@lvl}): restores #{heal_effect().round} HP, the more HP lost, the greater the effect(#{(HERO_HP_MOD * coeff_lvl() * 100).round}%). Cost #{@mp_cost} MP"
  end

  def description_short
    "Restores HP, the more HP lost, the greater the effect. Cost #{@mp_cost} MP"
  end
end











#
