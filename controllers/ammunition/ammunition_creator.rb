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
