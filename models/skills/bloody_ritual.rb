class BloodyRitual
  BASIC_MOD = 1
  LVL_MOD = 0.1
  HERO_MP_MOD = 0.3
  MIN_EFFECT = 10

  attr_accessor :lvl
  attr_reader :code, :name
  attr_accessor :hp_cost
  attr_reader :hero

  def initialize(hero)
    @code = 'bloody_ritual'
    @name = "Bloody ritual"
    @lvl = 0
    @hp_cost = 10

    @hero = hero
  end

  def coeff_lvl
    BASIC_MOD + LVL_MOD * @lvl
  end

  def restore_effect
    mp_dif = @hero.mp_max - @hero.mp
    min_effect = [mp_dif, MIN_EFFECT].min
    normal_effect = mp_dif * HERO_MP_MOD * coeff_lvl()
    [ [ min_effect, normal_effect ].max, mp_dif ].min.round # round for views display write MP value
  end

  def show_cost
    "#{@hp_cost} HP"
  end

  def description
    "Restores #{restore_effect().round} MP, the more MP lost, the greater the effect(#{(HERO_MP_MOD * coeff_lvl() * 100).round}%). Restores minimum #{MIN_EFFECT} MP"
  end

  def description_short
    "Cost #{@hp_cost} HP. Restores MP, the more MP lost, the greater the effect"
  end
end
