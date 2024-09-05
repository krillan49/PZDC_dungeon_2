class ArmsArmor
  attr_reader :code, :price
  attr_reader :basic_name, :basic_armor, :basic_accuracy
  attr_accessor :enhance, :enhance_name, :enhance_armor, :enhance_accuracy

  def initialize(code_name)
    @code = code_name
    arms_armor = YAML.safe_load_file('data/ammunition/arms_armor.yml', symbolize_names: true)[code_name.to_sym]
    @price = arms_armor[:price]

    @basic_name  = arms_armor[:name]
    @basic_armor = arms_armor[:armor]
    @basic_accuracy = arms_armor[:accuracy]

    @enhance = false
    @enhance_name = ''
    @enhance_armor = 0
    @enhance_accuracy = 0
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
end
