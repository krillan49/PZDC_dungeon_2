module AmmunitionCreator
  def self.create(ammunition_type, ammunition_name)
    case ammunition_type
    when 'weapon'; Weapon.new(ammunition_name)
    when 'body_armor'; BodyArmor.new(ammunition_name)
    when 'head_armor'; HeadArmor.new(ammunition_name)
    when 'arms_armor'; ArmsArmor.new(ammunition_name)
    when 'shield'; Shield.new(ammunition_name)
    end
  end
end

# require_relative "ammunition"
# p AmmunitionCreator.create('weapon', "Ржавый топорик")
# p AmmunitionCreator.create('body_armor', "leather_jacket")
# p AmmunitionCreator.create('head_armor', "rusty_topfhelm")
# p AmmunitionCreator.create('arms_armor', "quilted_gloves")
# p AmmunitionCreator.create('shield', "wooden_shield")
