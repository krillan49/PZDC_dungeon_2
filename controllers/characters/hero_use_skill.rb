module HeroUseSkill
  def self.camp_skill(hero, messages)
    if hero.hp_max - hero.hp > 0 && hero.camp_skill.name == "First aid"
      messages.main = "You have #{hero.hp.round}/#{hero.hp_max} HP, would you like to use #{hero.camp_skill.name}, to restore #{hero.camp_skill.heal_effect.round} hp for 10 mp? (Y/N)"
      MainRenderer.new(:messages_screen, entity: messages).display
      noncombat_choice = gets.strip.upcase
      if hero.mp >= hero.camp_skill.mp_cost && noncombat_choice == "Y"
        heal_effect_message = hero.camp_skill.heal_effect.round
        hero.hp += hero.camp_skill.heal_effect
        hero.mp -= hero.camp_skill.mp_cost
        messages.log << "You restored #{heal_effect_message} hp for #{hero.camp_skill.mp_cost} mp, now you have #{hero.hp.round}/#{hero.hp_max} hp and #{hero.mp.round}/#{hero.mp_max} mp"
      elsif noncombat_choice == "Y"
        messages.log << "Not enough mp"
      end
    end
  end
end
