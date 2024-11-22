# Аbstract base class for all ammunition classes

class Ammunition

  # info
  attr_reader :entity_type, :ammunition_type
  attr_reader :code, :price
  attr_reader :basic_name
  # basic_stats
  attr_reader :basic_armor, :basic_accuracy, :basic_block_chance,
  :basic_min_dmg, :basic_max_dmg, :basic_armor_penetration
  # enhance
  attr_accessor :enhance, :enhance_name,
  :enhance_armor, :enhance_accuracy, :enhance_block_chance,
  :enhance_min_dmg, :enhance_max_dmg, :enhance_armor_penetration


  # getters for combined values:

  def name # all
    @enhance ? '(E+) ' + @basic_name : @basic_name
  end

  def armor # all exept weapon
    not_less_than_zero(@basic_armor + @enhance_armor)
  end

  def accuracy # all
    @basic_accuracy + @enhance_accuracy
  end

  def block_chance # weapon & shield
    @basic_block_chance + @enhance_block_chance
  end

  def min_dmg # weapon & shield
    not_less_than_zero(@basic_min_dmg + @enhance_min_dmg)
  end

  def max_dmg # weapon & shield
    not_less_than_zero(@basic_max_dmg + @enhance_max_dmg)
  end

  def armor_penetration # weapon
    not_less_than_zero(@basic_armor_penetration + @enhance_armor_penetration)
  end

  private

  def not_less_than_zero(n)
    [n, 0].max
  end

end
