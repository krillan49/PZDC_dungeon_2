class Shield < Ammunition

  def initialize(code_name)
    @entity_type = 'ammunition'
    @ammunition_type = 'shield'

    @code = code_name
    shield = YAML.safe_load_file('data/ammunition/shield.yml', symbolize_names: true)[code_name.to_sym]
    @price = shield[:price]

    @basic_name  = shield[:name]
    @basic_armor = shield[:armor]
    @basic_accuracy = shield[:accuracy]
    @basic_block_chance = shield[:block_chance]
    @basic_min_dmg = shield[:min_dmg]
    @basic_max_dmg = shield[:max_dmg]

    @enhance = false
    @enhance_name = ''
    @enhance_min_dmg = 0
    @enhance_max_dmg = 0
    @enhance_armor = 0
    @enhance_accuracy = 0
    @enhance_block_chance = 0
  end

end
