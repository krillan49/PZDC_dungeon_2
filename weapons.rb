require 'yaml'

class Weapon
  WEAPONS = YAML.safe_load_file('weapons.yml', symbolize_names: true)

  attr_reader :name, :min_dmg, :max_dmg

  def initialize(name)
    @name = WEAPONS[name.to_sym][:name]
    @min_dmg = WEAPONS[name.to_sym][:min_dmg]
    @max_dmg = WEAPONS[name.to_sym][:max_dmg]
  end
end
