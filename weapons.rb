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
