module HeroUseSkill
  def self.camp_skill(hero, messages)
    if hero.hp_max - hero.hp > 0 && hero.camp_skill.name == "Первая помощь"
      messages.main = "У вас #{hero.hp.round}/#{hero.hp_max} жизней, хотите использовать навык #{hero.camp_skill.name}, чтобы восстановить #{hero.camp_skill.heal_effect.round} жизней за 10 маны? (Y/N)"
      MainRenderer.new(:messages_screen, entity: messages).display
      noncombat_choice = gets.strip.upcase
      if hero.mp >= hero.camp_skill.mp_cost && noncombat_choice == "Y"
        heal_effect_message = hero.camp_skill.heal_effect.round
        hero.hp += hero.camp_skill.heal_effect
        hero.mp -= hero.camp_skill.mp_cost
        messages.log << "Вы восстановили #{heal_effect_message} жизней за #{hero.camp_skill.mp_cost} маны, теперь у вас #{hero.hp.round}/#{hero.hp_max} жизней и #{hero.mp.round}/#{hero.mp_max} маны"
      elsif noncombat_choice == "Y"
        messages.log << "Не хватает маны"
      end
    end
  end
end
