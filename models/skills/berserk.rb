class Berserk
  BASIC_MOD = 0.5
  LVL_MOD = 0.05

  attr_accessor :lvl
  attr_reader :code, :name
  attr_reader :hero

  def initialize(hero)
    @code = 'berserk'
    @name = "Berserk"
    @lvl = 0

    @hero = hero
  end

  def damage_coef
    1 + (1 - @hero.hp.to_f / @hero.hp_max) * (BASIC_MOD + LVL_MOD * @lvl)
  end

  def description
    "(#{@lvl}): The less HP are left(#{@hero.hp.round}) from the maximum(#{@hero.hp_max}), the more damage X(#{damage_coef().round(2)})"
  end

  def description_short
    "The less HP the more damage"
  end
end
