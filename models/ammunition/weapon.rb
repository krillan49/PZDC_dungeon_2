class Weapon < Ammunition

  def initialize(code_name)
    @entity_type = 'ammunition'
    @ammunition_type = 'weapon'

    @code = code_name
    weapon = YAML.safe_load_file('data/ammunition/weapon.yml', symbolize_names: true)[code_name.to_sym]
    @price   = weapon[:price]

    @basic_name    = weapon[:name]
    @basic_min_dmg = weapon[:min_dmg]
    @basic_max_dmg = weapon[:max_dmg]
    @basic_accuracy = weapon[:accuracy]
    @basic_block_chance = weapon[:block_chance]
    @basic_armor_penetration = weapon[:armor_penetration]

    @enhance = false
    @enhance_name    = ''
    @enhance_min_dmg = 0
    @enhance_max_dmg = 0
    @enhance_accuracy = 0
    @enhance_block_chance = 0
    @enhance_armor_penetration = 0
  end

end
