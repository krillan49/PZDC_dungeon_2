module HeroUseSkill
  def self.camp_skill(hero, messages)
    if hero.camp_skill.code == "first_aid" && hero.hp_max - hero.hp > 0
      self.first_aid(hero, messages)
    elsif hero.camp_skill.code == "bloody_ritual" && hero.mp_max - hero.mp > 0
      self.bloody_ritual(hero, messages)
    else
      messages.main = 'BACK TO CAMP FIRE OPTIONS  [Enter 0]'
      messages.log << "You dont need use #{hero.camp_skill.name}. Your HP #{hero.hp}/#{hero.hp_max}, your MP #{hero.mp}/#{hero.mp_max}"
      MainRenderer.new(:messages_screen, entity: messages, arts: [{ camp_fire: :rest }]).display
      gets
    end
  end

  def self.first_aid(hero, messages)
    messages.main = "You have #{hero.hp.round}/#{hero.hp_max} HP and #{hero.mp.round}/#{hero.mp_max} MP. Use #{hero.camp_skill.name}, to restore #{hero.camp_skill.restore_effect.round} HP for 10 MP? (Y/N)"
    MainRenderer.new(:messages_screen, entity: messages, arts: [{ camp_fire: :rest }]).display
    noncombat_choice = gets.strip.upcase
    if hero.mp >= hero.camp_skill.mp_cost && noncombat_choice == "Y"
      effect_message = hero.camp_skill.restore_effect.round
      hero.hp += hero.camp_skill.restore_effect
      hero.mp -= hero.camp_skill.mp_cost
      messages.log << "You restored #{effect_message} HP for #{hero.camp_skill.mp_cost} MP, now you have #{hero.hp.round}/#{hero.hp_max} HP and #{hero.mp.round}/#{hero.mp_max} MP"
    elsif noncombat_choice == "Y"
      messages.log << "Not enough MP"
    end
    if noncombat_choice == "Y"
      messages.main = 'BACK TO CAMP FIRE OPTIONS  [Enter 0]'
      MainRenderer.new(:messages_screen, entity: messages, arts: [{ camp_fire: :rest }]).display
      gets
    end
  end

  def self.bloody_ritual(hero, messages)
    messages.main = "You have #{hero.hp.round}/#{hero.hp_max} HP and #{hero.mp.round}/#{hero.mp_max} MP. Use #{hero.camp_skill.name}, to restore #{hero.camp_skill.restore_effect.round} MP for 10 HP? (Y/N)"
    MainRenderer.new(:messages_screen, entity: messages, arts: [{ camp_fire: :rest }]).display
    noncombat_choice = gets.strip.upcase
    if hero.hp > hero.camp_skill.hp_cost && noncombat_choice == "Y"
      effect_message = hero.camp_skill.restore_effect.round
      hero.mp += hero.camp_skill.restore_effect
      hero.hp -= hero.camp_skill.hp_cost
      messages.log << "You restored #{effect_message} MP for #{hero.camp_skill.hp_cost} HP, now you have #{hero.mp.round}/#{hero.mp_max} MP and #{hero.hp.round}/#{hero.hp_max} HP"
    elsif noncombat_choice == "Y"
      messages.log << "Not enough HP"
    end
    if noncombat_choice == "Y"
      messages.main = 'BACK TO CAMP FIRE OPTIONS  [Enter 0]'
      MainRenderer.new(:messages_screen, entity: messages, arts: [{ camp_fire: :rest }]).display
      gets
    end
  end
end
