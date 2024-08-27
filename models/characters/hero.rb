class Hero
  attr_accessor :name
  attr_accessor :background, :background_name

  attr_accessor :hp_max, :hp, :regen_hp_base
  attr_accessor :mp_max, :mp, :regen_mp_base
  attr_accessor :min_dmg_base, :max_dmg_base
  attr_accessor :accuracy_base
  attr_accessor :armor_base
  # attr_accessor :block
  attr_accessor :exp, :lvl
  attr_accessor :exp_lvl
  attr_accessor :stat_points, :skill_points

  attr_accessor :active_skill, :passive_skill, :camp_skill

  attr_accessor :weapon, :body_armor, :head_armor, :arms_armor, :shield

  attr_accessor :pzdc_monolith_points, :coins, :ingredients

  attr_accessor :dungeon_name

  def initialize(name, background, dungeon_name=nil)
    @name = name
    @background = background
    @dungeon_name = dungeon_name

    hero = YAML.safe_load_file('data/characters/heroes.yml', symbolize_names: true)[background.to_sym]

    @background_name = hero[:name]

    @hp = hero[:hp]
    @hp_max = hero[:hp]
    @regen_hp_base = 0

    @mp = hero[:mp]
    @mp_max = hero[:mp]
    @regen_mp_base = 0

    @min_dmg_base = hero[:min_dmg]
    @max_dmg_base = hero[:max_dmg]

    @accuracy_base = hero[:accurasy]

    @armor_base = hero[:armor]

    @exp = 0
    @lvl = 0
    @exp_lvl = [0, 2, 5, 9, 14, 20, 27, 35, 44, 54, 65, 77, 90, 104, 129, 145, 162, 180, 200]

    @stat_points = 5
    @skill_points = hero[:skill_points]

    @pzdc_monolith_points = 0
    @coins = 0
    @ingredients = {}

    @weapon = Weapon.new(hero[:weapon])
    @body_armor = BodyArmor.new(hero[:body_armor].sample)
    @head_armor = HeadArmor.new(hero[:head_armor].sample)
    @arms_armor = ArmsArmor.new(hero[:arms_armor].sample)
    @shield = Shield.new(hero[:shield].sample)
  end

  # Геттеры - Методы зависимых характеристик:

  def min_dmg
    @min_dmg_base + @weapon.min_dmg
  end

  def max_dmg
    @max_dmg_base + @weapon.max_dmg
  end

  def recovery_hp
    @hp_max * 0.1
  end

  def recovery_mp
    @mp_max * 0.1
  end

  def regen_hp
    @regen_hp_base
  end

  def regen_mp
    @regen_mp_base
  end

  def armor
    @armor_base + @body_armor.armor + @head_armor.armor + @arms_armor.armor + @shield.armor
  end

  def accuracy
    @accuracy_base + @weapon.accuracy + @body_armor.accuracy + @head_armor.accuracy + @arms_armor.accuracy + @shield.accuracy
  end

  def block_chance
    if @passive_skill.name == "Shield master" && @shield.name != "---without---"
      @shield.block_chance + @passive_skill.block_chance_bonus
    else
      @shield.block_chance
    end
  end
  def block_power_coeff
    1 + @hp.to_f / 200
  end
  def block_power_in_percents
    100 - (100 / block_power_coeff()).to_i
  end

  def next_lvl_exp
    @exp_lvl[@lvl + 1]
  end
end
















#
