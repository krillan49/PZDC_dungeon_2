class BodyArmor
  attr_reader :code, :name, :armor, :price

  def initialize(name)
    @code = name
    body_armor = YAML.safe_load_file('data/ammunition/body_armor.yml', symbolize_names: true)[name.to_sym]
    @name  = body_armor[:name]
    @armor = body_armor[:armor]
    @price = body_armor[:price]
  end
end
