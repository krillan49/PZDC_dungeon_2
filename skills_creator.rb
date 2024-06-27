module SkillsCreator
  def self.create(skill_name, hero=nil)
    case skill_name
    when 'strong_strike'; StrongStrike.new
    when 'srecise_strike'; PreciseStrike.new
    when 'dazed'; Dazed.new
    when 'concentration'; Concentration.new(hero)
    when 'shield_master'; ShieldMaster.new
    when 'first_aid'; FirstAid.new(hero)
    when 'treasure_hunter'; TreasureHunter.new
    end
  end
end
