module HeroUseSkill
  def self.camp_skill(hero, messages)
    if hero.camp_skill.code == "first_aid" && hero.hp_max - hero.hp > 0
      self.first_aid(hero, messages)
    elsif hero.camp_skill.code == "bloody_ritual" && hero.mp_max - hero.mp > 0
      self.bloody_ritual(hero, messages)
    else
      messages.main = 'BACK TO CAMP FIRE OPTIONS  [Enter 0]'
      messages.log << "You dont need use #{hero.camp_skill.name}"
      self.display(hero, messages)
      gets
    end
  end

  def self.first_aid(hero, messages)
    noncombat_choice = nil
    until ['', '0', 'N'].include?(noncombat_choice)
      if hero.mp >= hero.camp_skill.mp_cost
        messages.main = "USE \"#{hero.camp_skill.name.upcase}\"  [Enter Y]        BACK TO CAMP FIRE OPTIONS  [Enter N]"
        messages.log << "Use #{hero.camp_skill.name}, to restore #{hero.camp_skill.restore_effect.round} HP for 10 MP?"
      else
        messages.main = 'BACK TO CAMP FIRE OPTIONS  [Enter 0]'
        messages.log << "Not enough MP for next use of \"#{hero.camp_skill.name}\""
      end
      self.display(hero, messages)
      noncombat_choice = gets.strip.upcase
      messages.log.pop
      if hero.mp >= hero.camp_skill.mp_cost && noncombat_choice == "Y"
        effect_message = hero.camp_skill.restore_effect.round
        hero.hp += hero.camp_skill.restore_effect
        hero.mp -= hero.camp_skill.mp_cost
        messages.log << "You restored #{effect_message} HP for #{hero.camp_skill.mp_cost} MP, now you have #{hero.hp.round}/#{hero.hp_max} HP and #{hero.mp.round}/#{hero.mp_max} MP"
      end
      messages.log.shift while messages.log.length > 5
    end
  end

  def self.bloody_ritual(hero, messages)
    noncombat_choice = nil
    until ['', '0', 'N'].include?(noncombat_choice)
      if hero.hp > hero.camp_skill.hp_cost
        messages.main = "USE \"#{hero.camp_skill.name.upcase}\"  [Enter Y]        BACK TO CAMP FIRE OPTIONS  [Enter N]"
        messages.log << "Use #{hero.camp_skill.name}, to restore #{hero.camp_skill.restore_effect.round} MP for 10 HP?"
      else
        messages.main = 'BACK TO CAMP FIRE OPTIONS  [Enter 0]'
        messages.log << "Not enough HP for next use of \"#{hero.camp_skill.name}\""
      end
      self.display(hero, messages)
      noncombat_choice = gets.strip.upcase
      messages.log.pop
      if hero.hp > hero.camp_skill.hp_cost && noncombat_choice == "Y"
        effect_message = hero.camp_skill.restore_effect.round
        hero.mp += hero.camp_skill.restore_effect
        hero.hp -= hero.camp_skill.hp_cost
        messages.log << "You restored #{effect_message} MP for #{hero.camp_skill.hp_cost} HP, now you have #{hero.mp.round}/#{hero.mp_max} MP and #{hero.hp.round}/#{hero.hp_max} HP"
      end
      messages.log.shift while messages.log.length > 5
    end
  end

  def self.display(hero, messages)
    MainRenderer.new(:camp_skill_screen, hero, entity: messages, arts: [{ camp_fire: :rest }]).display
  end

end
