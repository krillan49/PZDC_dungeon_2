class SkillsShow
  SKILLS_BY_TYPES = {
    'active_skill' => %w[precise_strike strong_strike traumatic_strike],
    'passive_skill' => %w[berserk concentration dazed shield_master],
    'camp_skill' => %w[bloody_ritual first_aid treasure_hunter],
    'all' => [
      'precise_strike', 'strong_strike', 'traumatic_strike',
      'berserk', 'concentration', 'dazed', 'shield_master',
      'bloody_ritual', 'first_aid', 'treasure_hunter'
    ]
  }

  def initialize(skill_type='all')
    @skills = SKILLS_BY_TYPES[skill_type]
  end

  def show_in_hero_creator(hero)
    @skills.map.with_index(1) do |skill_code, i|
      skill = SkillsCreator.create(skill_code, hero)
      aligned_skill_name = skill.name + (' ' * (25 - skill.name.length))
      "   [Enter #{i}]   #{aligned_skill_name} #{skill.description_short}"
    end
  end

  def SkillsShow.indexes_of_type(skill_type)
    SKILLS_BY_TYPES[skill_type].map.with_index(1){|_,i| i.to_s}
  end

  def SkillsShow.skill_code_by_index(skill_type, i)
    SKILLS_BY_TYPES[skill_type][i]
  end

end
