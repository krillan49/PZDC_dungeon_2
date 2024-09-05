class Weapon
  attr_reader :code, :price
  attr_reader :basic_name, :basic_min_dmg, :basic_max_dmg, :basic_accuracy
  attr_accessor :enhance, :enhance_name, :enhance_min_dmg, :enhance_max_dmg, :enhance_accuracy

  def initialize(code_name)
    @code = code_name
    weapon = YAML.safe_load_file('data/ammunition/weapon.yml', symbolize_names: true)[code_name.to_sym]
    @price   = weapon[:price]

    @basic_name    = weapon[:name]
    @basic_min_dmg = weapon[:min_dmg]
    @basic_max_dmg = weapon[:max_dmg]
    @basic_accuracy = weapon[:accuracy]

    @enhance = false
    @enhance_name    = ''
    @enhance_min_dmg = 0
    @enhance_max_dmg = 0
    @enhance_accuracy = 0
  end

  def name
    @enhance ? @basic_name + ' (E+)' : @basic_name
  end

  def min_dmg
    @basic_min_dmg + @enhance_min_dmg
  end

  def max_dmg
    @basic_max_dmg + @enhance_max_dmg
  end

  def accuracy
    @basic_accuracy + @enhance_accuracy
  end
end
