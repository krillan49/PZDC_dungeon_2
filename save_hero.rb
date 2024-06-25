require 'yaml'

class SaveHero
  def initialize(hero)
    @hero = hero
    @n = 0
    @name = "save/#{@n}. #{hero.name} #{hero.lvl}.yml"
    @text = ''
  end

  def save
    record = @hero
    File.write("save/#{@name}", record.to_yaml, mode: 'w')
  end
end

require_relative 'hero'
require_relative "skills"
p hero = Hero.new('Vasya','watchman')
# SaveHero.new(hero)

@name="Vasya"
@background="Сторож"
@hp=130, @hp_max=130, @regen_hp_base=0
@mp=100, @mp_max=100, @regen_mp_base=0
@min_dmg_base=5, @max_dmg_base=5
@accuracy_base=80
@armor_base=0
@exp=0, @lvl=0, @exp_lvl=[0, 2, 5, 9, 14, 20, 27, 35, 44, 54, 65, 77, 90, 104, 129, 145, 162, 180, 200],
@stat_points=5, @skill_points=0,
@weapon=#<Weapon:0x000001978ef0bb90 @name="Дубинка", @min_dmg=3, @max_dmg=4>,
@body_armor=#<BodyArmor:0x000001978eeff778 @name="без нагрудника", @armor=0>,
@head_armor=#<HeadArmor:0x000001978eefdc98 @name="без шлема", @armor=0>,
@arms_armor=#<ArmsArmor:0x000001978eef7320 @name="без перчаток", @armor=0, @accuracy=0>,
@shield=#<Shield:0x000001978eef47d8 @name="без щита", @armor=0, @block_chance=0
