class FirstAid
  HEAL_BASIC_MOD = 1
  HEAL_LVL_MOD = 0.1
  HERO_HP_MOD = 0.2
  MIN_EFFECT = 5

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

  def restore_effect
    [[@hero.hp_max - @hero.hp, MIN_EFFECT].min, (@hero.hp_max - @hero.hp) * HERO_HP_MOD * coeff_lvl()].max
  end

  def show_cost
    "#{@mp_cost} MP"
  end

  def description
    "Restores #{restore_effect().round} HP, the more HP lost, the greater the effect(#{(HERO_HP_MOD * coeff_lvl() * 100).round}%). Restores minimum #{MIN_EFFECT} HP"
  end

  def description_short
    "Cost #{@mp_cost} MP. Restores HP, the more HP lost, the greater the effect. Restores minimum #{MIN_EFFECT} HP"
  end
end











#
