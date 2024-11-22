class BodyArmor < Ammunition

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

end
