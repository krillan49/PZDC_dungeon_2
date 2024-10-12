class Enemy
  attr_reader :entity_type
  attr_reader :name, :code, :code_name, :dungeon_name
  attr_accessor :hp_max, :hp, :regen_hp_base
  attr_accessor :mp_max, :mp, :regen_mp_base
  attr_accessor :min_dmg_base, :max_dmg_base
  attr_accessor :accuracy_base
  attr_accessor :armor_base
  attr_accessor :armor_penetration_base
  attr_reader :exp_gived, :coins_gived, :ingredients

  attr_reader :weapon, :body_armor, :head_armor, :arms_armor, :shield

  def initialize(code, dungeon_name)
    @entity_type = 'enemyes'

    @code          = code
    @dungeon_name  = dungeon_name

    enemy = YAML.safe_load_file("data/characters/enemyes/#{dungeon_name}.yml", symbolize_names: true)[code.to_sym]

    @code_name     = enemy[:code_name]

    @name          = enemy[:name]
    @hp_max        = enemy[:hp]
    @hp            = enemy[:hp]
    @regen_hp_base = enemy[:regen_hp_base]
    @mp            = 0
    @mp_max        = 0
    @regen_mp_base = 0
    @min_dmg_base  = enemy[:min_dmg]
    @max_dmg_base  = enemy[:max_dmg]
    @armor_penetration_base = enemy[:armor_penetration]
    @accuracy_base = enemy[:accurasy]
    @armor_base    = enemy[:armor]
    @exp_gived     = enemy[:exp_gived]
    @coins_gived   = rand(0..enemy[:coins_gived])
    @ingredients   = enemy[:ingredients].sample

    @weapon = Weapon.new(enemy[:weapon].sample)
    @body_armor = BodyArmor.new(enemy[:body_armor].sample)
    @head_armor = HeadArmor.new(enemy[:head_armor].sample)
    @arms_armor = ArmsArmor.new(enemy[:arms_armor].sample)
    @shield = Shield.new(enemy[:shield].sample)
  end

  # Геттеры - Методы зависимых характеристик:

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
    @shield.block_chance + @weapon.block_chance
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

  # Setters dependent characteristics

  def add_hp_not_higher_than_max(n=0)
    @hp += [n, @hp_max - @hp].min
  end

end













#
