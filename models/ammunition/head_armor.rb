class HeadArmor
  attr_reader :entity_type, :ammunition_type
  attr_reader :code, :price
  attr_reader :basic_name, :basic_armor, :basic_accuracy
  attr_accessor :enhance, :enhance_name, :enhance_armor, :enhance_accuracy

  def initialize(code_name)
    @entity_type = 'ammunition'
    @ammunition_type = 'head_armor'

    @code = code_name
    head_armor = YAML.safe_load_file('data/ammunition/head_armor.yml', symbolize_names: true)[code_name.to_sym]
    @price = head_armor[:price]

    @basic_name  = head_armor[:name]
    @basic_armor = head_armor[:armor]
    @basic_accuracy = head_armor[:accuracy]

    @enhance = false
    @enhance_name = ''
    @enhance_armor = 0
    @enhance_accuracy = 0
  end

  def name
    @enhance ? '(E+) ' + @basic_name : @basic_name
  end

  def armor
    not_less_than_zero(@basic_armor + @enhance_armor)
  end

  def accuracy
    @basic_accuracy + @enhance_accuracy
  end

  private

  def not_less_than_zero(n)
    [n, 0].max
  end

end
