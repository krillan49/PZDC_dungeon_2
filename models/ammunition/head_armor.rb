class HeadArmor
  attr_reader :code, :name, :armor

  def initialize(name)
    @code = name
    head_armor = YAML.safe_load_file('data/ammunition/head_armor.yml', symbolize_names: true)[name.to_sym]
    @name  = head_armor[:name]
    @armor = head_armor[:armor]
  end
end
