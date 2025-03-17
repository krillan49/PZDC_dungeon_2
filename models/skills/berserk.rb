class Berserk
  BASIC_MOD = 0.5
  LVL_MOD = 0.05

  attr_accessor :lvl
  attr_reader :entity_type, :code, :name
  attr_reader :hero

  def initialize(hero)
    @entity_type = 'skills'
    @code = 'berserk'
    @name = "Berserk"
    @lvl = 0

    @hero = hero
  end

  def damage_coef
    1 + (1 - @hero.hp.to_f / @hero.hp_max) * (BASIC_MOD + LVL_MOD * @lvl)
  end

  def show_cost
    'passive'
  end

  def show_damage
    ((damage_coef() - 1) * 100).round
  end

  def show_hp_part
    (@hero.hp.to_f/@hero.hp_max * 100).round
  end

  def description
    "The less HP - the more damage. HP is #{show_hp_part()}% from the maximum. Additional damage +#{show_damage()}%"
  end

  def description_short
    "The less HP are left - the more damage you done"
  end
end
