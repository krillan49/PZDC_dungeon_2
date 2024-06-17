class StrongStrike
  DAMAGE_BASIC_MOD = 2
  DAMAGE_LVL_MOD = 0.2
  ACCURACY_MOD = 1

  attr_accessor :lvl, :mp_cost
  attr_reader :name

  def initialize
    @name = "Сильный удар"
    @lvl = 0
    @mp_cost = 15
  end

  def damage_mod
    DAMAGE_BASIC_MOD + DAMAGE_LVL_MOD * @lvl
  end

  def accuracy_mod
    ACCURACY_MOD
  end

  def description
    "(#{@lvl}): урон сильнее в #{damage_mod().round(1)}, наносится по телу. Цена #{@mp_cost}"
  end
end


class PreciseStrike
  DAMAGE_BASIC_MOD = 1
  DAMAGE_LVL_MOD = 0.1
  ACCURACY_BASIC_MOD = 1.5
  ACCURACY_LVL_MOD = 0.1

  attr_accessor :lvl, :mp_cost
  attr_reader :name

  def initialize
    @name = "Точный удар"
    @lvl = 0
    @mp_cost = 5
  end

  def damage_mod
    DAMAGE_BASIC_MOD + DAMAGE_LVL_MOD * @lvl
  end

  def accuracy_mod
    ACCURACY_BASIC_MOD + ACCURACY_LVL_MOD * @lvl
  end

  def description
    "(#{@lvl}): точнее в #{accuracy_mod().round(1)}, сильнее в #{damage_mod().round(1)} наносится по телу. Цена #{@mp_cost}"
  end
end

# [StrongStrike.new, PreciseStrike.new].each do |n|
#   p n
#   p n.accuracy_mod
#   p n.description
#   n.lvl += 3
#   p n
#   p n.accuracy_mod
#   p n.description
#   p '--------------------'
# end


class Dazed
  BASIC_MOD = 1
  LVL_MOD = 0.1

  attr_accessor :lvl
  attr_reader :name

  def initialize
    @name = "Ошеломление"
    @lvl = 0
  end

  def accuracy_reduce_coef
    BASIC_MOD + LVL_MOD * @lvl
  end

  def accuracy_reduce_percent
    100 / (2 * accuracy_reduce_coef())
  end

  def description
    "(#{@lvl}): если урон больше #{accuracy_reduce_percent().round}% осташихся жизней врага то он теряет 10-90(%) точности"
  end
end


class Concentration
  BASIC_MOD = 0.1
  LVL_MOD = 0.005

  attr_accessor :lvl
  attr_reader :name

  def initialize(hero)
    @name = "Концентрация"
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
    "(#{@lvl}): если мана больше 100(#{@hero.mp_max}) наносится случайный доп урон до #{damage_coef().round(1)}"
  end
end


class ShieldMaster
  BASIC_CHANCE_MOD = 10
  LVL_CHANCE_MOD = 2

  attr_accessor :lvl
  attr_reader :name

  def initialize
    @name = "Мастер щита"
    @lvl = 0
  end

  def block_chance_bonus
    BASIC_CHANCE_MOD + LVL_CHANCE_MOD * @lvl
  end

  def description
    "(#{@lvl}): шанс блока щитом увеличен на #{block_chance_bonus()}%"
  end
end




class FirstAid
  HEAL_BASIC_MOD = 1
  HEAL_LVL_MOD = 0.1
  HERO_HP_MOD = 0.2

  attr_accessor :lvl, :mp_cost
  attr_reader :name
  attr_reader :hero

  def initialize(hero)
    @name = "Первая помощь"
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
    "(#{@lvl}): восстанавливает #{heal_effect().round} жизней, чем больше жизней потеряно, тем больше эффект(#{(HERO_HP_MOD * coeff_lvl() * 100).round}%), цена #{@mp_cost} маны."
  end
end


class TreasureHunter
  BASIC_MOD = 50
  LVL_MOD = 5

  attr_accessor :lvl
  attr_reader :name

  def initialize
    @name = "Кладоискатель"
    @lvl = 0
  end

  def coeff_lvl
    BASIC_MOD + LVL_MOD * @lvl
  end

  def description
    "(#{@lvl}): дополнительный бонус очков поиска сокровищ = #{coeff_lvl()}"
  end
end












#
