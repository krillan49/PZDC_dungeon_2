class HeadArmor < Ammunition

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

end
