module HeroActions
  def self.rest(hero) # отдых между боями(Восстановления жизней и маны)
    if hero.hp < hero.hp_max
      hero.hp += [hero.recovery_hp, hero.hp_max - hero.hp].min
      puts "Передохнув вы восстанавливаете #{hero.recovery_hp.round} жизней, теперь у вас #{hero.hp.round}/#{hero.hp_max} жизней"
    end
    if hero.mp < hero.mp_max
      hero.mp += [hero.recovery_mp, hero.mp_max - hero.mp].min
      puts "Передохнув вы восстанавливаете #{hero.recovery_mp.round} выносливости, теперь у вас #{hero.mp.round}/#{hero.mp_max} выносливости"
    end
  end

  def self.regeneration_hp_mp(hero, messages) # регенерация в бою
    if hero.regen_hp > 0 && hero.hp_max > hero.hp
      hero.hp += [hero.regen_hp, hero.hp_max - hero.hp].min
      messages.log << "Вы регенерируете #{hero.regen_hp} жизней, теперь у вас #{hero.hp.round}/#{hero.hp_max} жизней"
    end
    if hero.regen_mp > 0 && hero.mp_max > hero.mp
      hero.mp += [hero.regen_mp, hero.mp_max - hero.mp].min
      messages.log << "Вы регенерируете #{hero.regen_mp} выносливости, теперь у вас #{hero.mp.round}/#{hero.mp_max} выносливости"
    end
  end

  def self.add_exp_and_hero_level_up(hero, added_exp, messages) # получения нового опыта, уровня, очков характеристик и наыков
    hero.exp += added_exp
    messages.log << "Вы получили #{added_exp} опыта. Теперь у вас #{hero.exp} опыта"
    hero.exp_lvl.each.with_index do |exp_val, i|
      if hero.exp >= exp_val && hero.lvl < i
        new_levels = i - hero.lvl
        hero.stat_points += new_levels
        hero.skill_points += new_levels
        hero.lvl += new_levels
        messages.log << "Вы получили новый уровень, теперь ваш уровень #{hero.lvl}й"
        messages.log << "Вы получили #{new_levels} очков характеристик и #{new_levels} очков навыков"
        messages.log << "У вас теперь #{hero.stat_points} очков характеристик и #{hero.skill_points} очков навыков"
      end
    end
  end
end
