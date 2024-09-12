class BloodyRitual
  BASIC_MOD = 1
  LVL_MOD = 0.1
  HERO_MP_MOD = 0.2

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
    (@hero.mp_max - @hero.mp) * HERO_MP_MOD * coeff_lvl()
  end

  def show_cost
    "#{@hp_cost} HP"
  end

  def description
    "Restores #{restore_effect().round} MP, the more MP lost, the greater the effect(#{(HERO_MP_MOD * coeff_lvl() * 100).round}%)"
  end

  def description_short
    "Restores MP, the more MP lost, the greater the effect. Cost #{@hp_cost} HP"
  end
end
