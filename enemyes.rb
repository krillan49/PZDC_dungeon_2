require 'yaml'
require_relative 'weapons'

class Enemy
  attr_reader :name
  attr_accessor :hp
  attr_accessor :min_dmg_base, :max_dmg_base
  attr_accessor :accuracy_base
  attr_accessor :armor_base
  attr_reader :exp_gived

  attr_reader :weapon, :body_armor, :head_armor, :arms_armor, :shield

  def initialize(name)
    enemy = YAML.safe_load_file('data/characters/enemyes.yml', symbolize_names: true)[name.to_sym]

    @name          = enemy[:name]
    @hp            = enemy[:hp]
    @min_dmg_base  = enemy[:min_dmg]
    @max_dmg_base  = enemy[:max_dmg]
    @accuracy_base = enemy[:accurasy]
    @armor_base    = enemy[:armor]
    @exp_gived     = enemy[:exp_gived]

    @weapon = Weapon.new(enemy[:weapons].sample)
    @body_armor = BodyArmor.new(enemy[:body_armor].sample)
    @head_armor = HeadArmor.new(enemy[:head_armor].sample)
    @arms_armor = ArmsArmor.new(enemy[:arms_armor].sample)
    @shield = Shield.new(enemy[:shields].sample)
  end

  # Геттеры - Методы зависимых характеристик:

  def min_dmg
    @min_dmg_base + @weapon.min_dmg
  end

  def max_dmg
    @max_dmg_base + @weapon.max_dmg
  end

  def armor
    @armor_base + @body_armor.armor + @head_armor.armor + @arms_armor.armor + @shield.armor
  end

  def accuracy
    @accuracy_base + @arms_armor.accuracy
  end

  def block_chance
    @shield.block_chance
  end

  def block_power_coeff
    1 + @hp.to_f / 200
  end
  def block_power_in_percents
    100 - (100 / block_power_coeff()).to_i
  end
end

# ["Оборванец", "Бешеный пес", "Гоблин", "Бандит", "Дезертир", "Орк", "Рыцарь-зомби"].each do |name|
#   p Enemy.new(name)
#   p '==================='
# end













#
