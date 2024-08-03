module HeroActions
  def self.rest(hero, messages) # отдых между боями(Восстановления жизней и маны)
    if hero.hp < hero.hp_max
      hero.hp += [hero.recovery_hp, hero.hp_max - hero.hp].min
      messages.log << "After resting, you restore #{hero.recovery_hp.round} hp, now you have #{hero.hp.round}/#{hero.hp_max} hp"
    end
    if hero.mp < hero.mp_max
      hero.mp += [hero.recovery_mp, hero.mp_max - hero.mp].min
      messages.log << "After resting, you restore #{hero.recovery_mp.round} mp, now you have #{hero.mp.round}/#{hero.mp_max} mp"
    end
  end

  def self.regeneration_hp_mp(hero, messages) # регенерация в бою
    if hero.regen_hp > 0 && hero.hp_max > hero.hp
      hero.hp += [hero.regen_hp, hero.hp_max - hero.hp].min
      messages.log << "Regenerating #{hero.regen_hp} hp, now you have #{hero.hp.round}/#{hero.hp_max} hp"
    end
    if hero.regen_mp > 0 && hero.mp_max > hero.mp
      hero.mp += [hero.regen_mp, hero.mp_max - hero.mp].min
      messages.log << "Regenerating #{hero.regen_mp} mp, now you have #{hero.mp.round}/#{hero.mp_max} mp"
    end
  end

  def self.add_exp_and_hero_level_up(hero, added_exp, messages) # получения нового опыта, уровня, очков характеристик и наыков
    hero.exp += added_exp
    messages.log << "You have gained #{added_exp} exp, now you have #{hero.exp} exp"
    hero.exp_lvl.each.with_index do |exp_val, i|
      if hero.exp >= exp_val && hero.lvl < i
        new_levels = i - hero.lvl
        hero.stat_points += new_levels
        hero.skill_points += new_levels
        hero.lvl += new_levels
        messages.log << "You have gained a new level, now your level is #{hero.lvl}"
        messages.log << "You have gained #{new_levels} stat points and #{new_levels} skill points"
        messages.log << "You have #{hero.stat_points} stat points and #{hero.skill_points} skill points"
      end
    end
  end
end
