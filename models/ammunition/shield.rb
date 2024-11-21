class Shield
  attr_reader :entity_type, :ammunition_type
  attr_reader :code, :price
  attr_reader :basic_name, :basic_min_dmg, :basic_max_dmg, :basic_armor, :basic_accuracy, :basic_block_chance
  attr_accessor :enhance, :enhance_name, :enhance_armor, :enhance_accuracy, :enhance_block_chance,
                :enhance_min_dmg, :enhance_max_dmg

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

  def name
    @enhance ? '(E+) ' + @basic_name : @basic_name
  end

  def min_dmg
    not_less_than_zero(@basic_min_dmg + @enhance_min_dmg)
  end

  def max_dmg
    not_less_than_zero(@basic_max_dmg + @enhance_max_dmg)
  end

  def armor
    not_less_than_zero(@basic_armor + @enhance_armor)
  end

  def accuracy
    @basic_accuracy + @enhance_accuracy
  end

  def block_chance
    @basic_block_chance + @enhance_block_chance
  end

  private

  def not_less_than_zero(n)
    [n, 0].max
  end

end
