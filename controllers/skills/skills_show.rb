class SkillsShow
  SKILLS_BY_TYPES = {
    'active_skill' => %w[precise_strike strong_strike],
    'passive_skill' => %w[berserk concentration dazed shield_master],
    'camp_skill' => %w[first_aid treasure_hunter],
    'all' => [
      'precise_strike', 'strong_strike',
      'berserk', 'concentration', 'dazed', 'shield_master',
      'first_aid', 'treasure_hunter'
    ]
  }

  def initialize(type='all')
    @skills = SKILLS_BY_TYPES[type]
  end

  def show_in_hero_creator(hero)
    @skills.map!.with_index(1) do |skill_code, i|
      skill = SkillsCreator.create(skill_code, hero)
      aligned_skill_name = skill.name + (' ' * (25 - skill.name.length))
      "   [Enter #{i}]   #{aligned_skill_name} #{skill.description_short}"
    end
  end

end
