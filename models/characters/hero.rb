class Hero
  attr_accessor :name
  attr_accessor :background, :background_name

  attr_accessor :hp_max, :hp, :regen_hp_base
  attr_accessor :mp_max, :mp, :regen_mp_base
  attr_accessor :min_dmg_base, :max_dmg_base
  attr_accessor :accuracy_base
  attr_accessor :armor_base
  attr_accessor :block_chance_base
  attr_accessor :armor_penetration_base
  attr_accessor :exp, :lvl
  attr_accessor :exp_lvl
  attr_accessor :stat_points, :skill_points

  attr_accessor :active_skill, :passive_skill, :camp_skill

  attr_accessor :weapon, :body_armor, :head_armor, :arms_armor, :shield

  attr_accessor :pzdc_monolith_points, :coins, :ingredients

  attr_accessor :dungeon_name, :dungeon_part_number, :leveling

  attr_accessor :statistics, :events_data

  def initialize(name, background, dungeon_name=nil)
    @name = name
    @background = background
    @dungeon_name = dungeon_name
    @dungeon_part_number = 1

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
    @armor_penetration_base = hero[:armor_penetration]

    @accuracy_base = hero[:accurasy]

    @armor_base = hero[:armor]

    @block_chance_base = 0

    @exp = 0
    @lvl = 0
    @exp_lvl = [0, 2, 5, 9, 14, 20, 27, 35, 44, 54, 65, 77, 90, 104, 129, 145, 162, 180, 200]

    @stat_points = 5
    @skill_points = hero[:skill_points]

    @pzdc_monolith_points = 0
    @coins = 0
    @ingredients = {}

    @events_data = {}

    @leveling = 0

    @weapon = Weapon.new(hero[:weapon])
    @body_armor = BodyArmor.new(hero[:body_armor].sample)
    @head_armor = HeadArmor.new(hero[:head_armor].sample)
    @arms_armor = ArmsArmor.new(hero[:arms_armor].sample)
    @shield = Shield.new(hero[:shield].sample)
  end

  # Getters dependent characteristics

  def min_dmg
    @min_dmg_base + @weapon.min_dmg + @shield.min_dmg
  end

  def max_dmg
    @max_dmg_base + @weapon.max_dmg + @shield.max_dmg
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
    res_block_chance = @block_chance_base + @shield.block_chance + @weapon.block_chance
    if @passive_skill.name == "Shield master" && @shield.name != "---without---"
      res_block_chance += @passive_skill.block_chance_bonus
    end
    res_block_chance
  end
  def block_power_coeff
    1 + @hp.to_f / 200
  end
  def block_power_in_percents
    100 - (100 / block_power_coeff()).to_i
  end

  def armor_penetration
    @armor_penetration_base + @weapon.armor_penetration
  end

  def next_lvl_exp
    @exp_lvl[@lvl + 1]
  end

  # Setters dependent characteristics

  def add_dmg_base(n=1)
    n.times do
      @min_dmg_base < @max_dmg_base && rand(0..1) == 0 ? @min_dmg_base += 1 : @max_dmg_base += 1
    end
  end

  def reduce_dmg_base(n=1)
    n.times do
      @min_dmg_base < @max_dmg_base && rand(0..1) == 0 ? @max_dmg_base -= 1 : @min_dmg_base -= 1
    end
  end

  def add_hp_not_higher_than_max(n=0)
    @hp += [n, @hp_max - @hp].min
  end

  def add_mp_not_higher_than_max(n=0)
    @mp += [n, @mp_max - @mp].min
  end

  def reduce_mp_not_less_than_zero(n=0)
    @mp -= n
    @mp = @mp < 0 ? 0 : @mp
  end

  def reduce_coins_not_less_than_zero(n=0)
    @coins -= n
    @coins = @coins < 0 ? 0 : @coins
  end

end
















#
