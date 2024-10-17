module AmmunitionCreator
  def self.create(ammunition_type, ammunition_code)
    case ammunition_type
    when 'weapon'; Weapon.new(ammunition_code)
    when 'body_armor'; BodyArmor.new(ammunition_code)
    when 'head_armor'; HeadArmor.new(ammunition_code)
    when 'arms_armor'; ArmsArmor.new(ammunition_code)
    when 'shield'; Shield.new(ammunition_code)
    end
  end
end
