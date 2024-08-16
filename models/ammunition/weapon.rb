class Weapon
  attr_reader :code, :name, :min_dmg, :max_dmg, :price

  def initialize(name)
    @code = name
    weapon = YAML.safe_load_file('data/ammunition/weapon.yml', symbolize_names: true)[name.to_sym]
    @name    = weapon[:name]
    @min_dmg = weapon[:min_dmg]
    @max_dmg = weapon[:max_dmg]
    @price   = weapon[:price]
  end
end
