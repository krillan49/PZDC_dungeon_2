class Shield
  attr_reader :code, :price
  attr_reader :basic_name, :basic_armor, :basic_accuracy, :basic_block_chance
  attr_accessor :enhance, :enhance_name, :enhance_armor, :enhance_accuracy, :enhance_block_chance

  def initialize(code_name)
    @code = code_name
    shield = YAML.safe_load_file('data/ammunition/shield.yml', symbolize_names: true)[code_name.to_sym]
    @price = shield[:price]

    @basic_name  = shield[:name]
    @basic_armor = shield[:armor]
    @basic_accuracy = shield[:accuracy]
    @basic_block_chance = shield[:block_chance]

    @enhance = false
    @enhance_name = ''
    @enhance_armor = 0
    @enhance_accuracy = 0
    @enhance_block_chance = 0
  end

  def name
    @enhance ? '(E+) ' + @basic_name : @basic_name
  end

  def armor
    @basic_armor + @enhance_armor
  end

  def accuracy
    @basic_accuracy + @enhance_accuracy
  end

  def block_chance
    @basic_block_chance + @enhance_block_chance
  end
end
