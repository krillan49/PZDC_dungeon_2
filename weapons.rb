require 'yaml'

class Weapon
  attr_reader :name, :min_dmg, :max_dmg

  def initialize(name)
    weapon = YAML.safe_load_file('data/amunition/weapons.yml', symbolize_names: true)[name.to_sym]
    @name    = weapon[:name]
    @min_dmg = weapon[:min_dmg]
    @max_dmg = weapon[:max_dmg]
  end
end

class BodyArmor
  attr_reader :name, :armor

  def initialize(name)
    body_armor = YAML.safe_load_file('data/amunition/body_armor.yml', symbolize_names: true)[name.to_sym]
    @name  = body_armor[:name]
    @armor = body_armor[:armor]
  end
end

class HeadArmor
  attr_reader :name, :armor

  def initialize(name)
    head_armor = YAML.safe_load_file('data/amunition/head_armor.yml', symbolize_names: true)[name.to_sym]
    @name  = head_armor[:name]
    @armor = head_armor[:armor]
  end
end

class ArmsArmor
  attr_reader :name, :armor, :accuracy

  def initialize(name)
    arms_armor = YAML.safe_load_file('data/amunition/arms_armor.yml', symbolize_names: true)[name.to_sym]
    @name  = arms_armor[:name]
    @armor = arms_armor[:armor]
    @accuracy = arms_armor[:accuracy]
  end
end

class Shield
  attr_reader :name, :armor, :block_chance

  def initialize(name)
    shield = YAML.safe_load_file('data/amunition/shields.yml', symbolize_names: true)[name.to_sym]
    @name  = shield[:name]
    @armor = shield[:armor]
    @block_chance = shield[:block_chance]
  end
end


# %w[without braided_buckler wooden_buckler wooden_shield].each do |armor|
#   p Shield.new(armor)
# end

# %w[without leather_gloves quilted_gloves rusty_mail_gloves].each do |armor|
#   p ArmsArmor.new(armor)
# end

# %w[without leather_helmet quilted_helmet rusty_topfhelm].each do |armor|
#   p HeadArmor.new(armor)
# end

# %w[without leather_jacket gambeson rusty_cuirass].each do |armor|
#   p BodyArmor.new(armor)
# end















#
