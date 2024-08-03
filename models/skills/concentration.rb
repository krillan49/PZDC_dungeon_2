class Concentration
  BASIC_MOD = 0.1
  LVL_MOD = 0.005

  attr_accessor :lvl
  attr_reader :code, :name
  attr_reader :hero

  def initialize(hero)
    @code = 'concentration'
    @name = "Concentration"
    @lvl = 0

    @hero = hero
  end

  def damage_coef
    @hero.mp_max * (0.1 + 0.005 * @lvl) - 10
  end

  def damage_bonus
    rand(0..damage_coef()) || 0
  end

  def description
    "(#{@lvl}): if mp is more than 100(#{@hero.mp_max}) random additional damage is dealt up to #{damage_coef().round(1)}"
  end
end












#
