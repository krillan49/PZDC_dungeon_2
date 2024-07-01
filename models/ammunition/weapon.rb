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
