class Weapon
  attr_reader :entity_type, :ammunition_type
  attr_reader :code, :price
  attr_reader :basic_name, :basic_min_dmg, :basic_max_dmg, :basic_accuracy, :basic_block_chance, :basic_armor_penetration
  attr_accessor :enhance, :enhance_name, :enhance_min_dmg, :enhance_max_dmg, :enhance_accuracy, :enhance_block_chance, :enhance_armor_penetration

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

  def name
    @enhance ? '(E+) ' + @basic_name : @basic_name
  end

  def min_dmg
    res_min_dmg = @basic_min_dmg + @enhance_min_dmg
    res_min_dmg >= 0 ? res_min_dmg : 0
  end

  def max_dmg
    res_max_dmg = @basic_max_dmg + @enhance_max_dmg
    res_max_dmg >= 0 ? res_max_dmg : 0
  end

  def accuracy
    @basic_accuracy + @enhance_accuracy
  end

  def block_chance
    @basic_block_chance + @enhance_block_chance
  end

  def armor_penetration
    @basic_armor_penetration + @enhance_armor_penetration
  end

end
