class ArmsArmor < Ammunition

  def initialize(code_name)
    @entity_type = 'ammunition'
    @ammunition_type = 'arms_armor'

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

end
