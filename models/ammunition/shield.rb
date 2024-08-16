class Shield
  attr_reader :code, :name, :armor, :block_chance, :price

  def initialize(name)
    @code = name
    shield = YAML.safe_load_file('data/ammunition/shield.yml', symbolize_names: true)[name.to_sym]
    @name  = shield[:name]
    @armor = shield[:armor]
    @block_chance = shield[:block_chance]
    @price = shield[:price]
  end
end
