require 'yaml'
require_relative 'weapons'

class Enemy
  attr_accessor :name
  attr_accessor :hp#,:hp_max, :regen_hp_base, :regen_hp
  # attr_accessor :mp_max, :mp, :regen_mp_base, :regen_mp
  attr_accessor :min_dmg_base, :min_dmg, :max_dmg_base, :max_dmg
  attr_accessor :accuracy_base, :accuracy
  attr_accessor :armor_base, :armor
  attr_accessor :block_chance
  attr_reader :exp_gived

  attr_accessor :weapon, :body_armor, :head_armor, :arms_armor, :shield

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
end

# ["Оборванец", "Бешеный пес", "Гоблин", "Бандит", "Дезертир", "Орк", "Рыцарь-зомби"].each do |name|
#   p Enemy.new(name)
#   p '==================='
# end













#
