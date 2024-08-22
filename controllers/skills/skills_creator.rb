module SkillsCreator
  def self.create(skill_name, hero=nil)
    case skill_name
    when 'precise_strike'; PreciseStrike.new
    when 'strong_strike'; StrongStrike.new
    when 'berserk'; Berserk.new(hero)
    when 'concentration'; Concentration.new(hero)
    when 'dazed'; Dazed.new
    when 'shield_master'; ShieldMaster.new
    when 'first_aid'; FirstAid.new(hero)
    when 'treasure_hunter'; TreasureHunter.new
    end
  end
end
