require 'yaml'

class ArmsArmor
  attr_reader :code, :name, :armor, :accuracy

  def initialize(name)
    @code = name
    arms_armor = YAML.safe_load_file('data/ammunition/arms_armor.yml', symbolize_names: true)[name.to_sym]
    @name  = arms_armor[:name]
    @armor = arms_armor[:armor]
    @accuracy = arms_armor[:accuracy]
  end
end

# %w[without leather_gloves quilted_gloves rusty_mail_gloves].each do |armor|
#   p ArmsArmor.new(armor)
# end
