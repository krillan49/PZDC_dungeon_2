class BodyArmor
  attr_reader :entity_type, :ammunition_type
  attr_reader :code, :price
  attr_reader :basic_name, :basic_armor, :basic_accuracy
  attr_accessor :enhance, :enhance_name, :enhance_armor, :enhance_accuracy

  def initialize(code_name)
    @entity_type = 'ammunition'
    @ammunition_type = 'body_armor'

    @code = code_name
    body_armor = YAML.safe_load_file('data/ammunition/body_armor.yml', symbolize_names: true)[code_name.to_sym]
    @price = body_armor[:price]

    @basic_name  = body_armor[:name]
    @basic_armor = body_armor[:armor]
    @basic_accuracy = body_armor[:accuracy]

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
