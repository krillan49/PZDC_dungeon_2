require 'yaml'

class Weapon
  attr_reader :code, :name, :min_dmg, :max_dmg

  def initialize(name)
    @code = name
    weapon = YAML.safe_load_file('data/ammunition/weapons.yml', symbolize_names: true)[name.to_sym]
    @name    = weapon[:name]
    @min_dmg = weapon[:min_dmg]
    @max_dmg = weapon[:max_dmg]
  end
end

class BodyArmor
  attr_reader :code, :name, :armor

  def initialize(name)
    @code = name
    body_armor = YAML.safe_load_file('data/ammunition/body_armor.yml', symbolize_names: true)[name.to_sym]
    @name  = body_armor[:name]
    @armor = body_armor[:armor]
  end
end

class HeadArmor
  attr_reader :code, :name, :armor

  def initialize(name)
    @code = name
    head_armor = YAML.safe_load_file('data/ammunition/head_armor.yml', symbolize_names: true)[name.to_sym]
    @name  = head_armor[:name]
    @armor = head_armor[:armor]
  end
end

class ArmsArmor
  attr_reader :code, :name, :armor, :accuracy

  def initialize(name)
    @code = name
    arms_armor = YAML.safe_load_file('data/ammunition/arms_armor.yml', symbolize_names: true)[name.to_sym]
    @name  = arms_armor[:name]
    @armor = arms_armor[:armor]
    @accuracy = arms_armor[:accuracy]
  end
end

class Shield
  attr_reader :code, :name, :armor, :block_chance

  def initialize(name)
    @code = name
    shield = YAML.safe_load_file('data/ammunition/shields.yml', symbolize_names: true)[name.to_sym]
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
