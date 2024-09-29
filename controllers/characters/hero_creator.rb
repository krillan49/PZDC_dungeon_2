class HeroCreator

  def initialize(dungeon_name)
    @messages = MainMessage.new

    @hero = Hero.new(name(), background(), dungeon_name)
  end

  def create_new_hero
    monolith_bonuses()
    statistics_bonuses()
    shop_bonuses()
    active_skill()
    passive_skill()
    camp_skill()
    cheating()
    @hero
  end

  private

  def name
    name = nil
    while !name
      @messages.main = 'Enter character name' if @messages.main == ''
      @messages.log << 'The character name must contain at least 1 letter and be no more than 20 characters'
      MainRenderer.new(:messages_screen, entity: @messages).display
      input_name = gets.strip
      if !input_name.match?(/[a-zA-Zа-яА-Я]/)
        @messages.main = "#{input_name} is an incorrect name. The name must contain at least one letter"
      elsif input_name.length > 20
        @messages.main = "#{input_name} is an incorrect name. The name must be no more than 20 characters"
      else
        name = input_name
      end
    end
    name
  end

  def background
    @messages.main = 'Select a background'
    heroes = YAML.safe_load_file("data/characters/heroes.yml").to_a.sort_by{|code, hh| hh['n']}[1..]
    @messages.log = [
      'Background:'.ljust(13).rjust(28) + 'HP:'.ljust(12) + 'MP:'.ljust(12) + 'Min dmg:'.ljust(12) + 'Max dmg:'.ljust(12) + 'Accuracy:'.ljust(12) + 'Armor:'.ljust(12) + 'Skill points:',
    ]
    heroes.each do |code, hh|
      @messages.log << ' ' * 14 + '-' * 100
      @messages.log << [
        "   [Enter #{hh['n'].to_s.rjust(2)}]".ljust(15),
        hh['name'].ljust(13),
        hh['hp'].to_s.ljust(12),
        hh['mp'].to_s.ljust(12),
        hh['min_dmg'].to_s.ljust(12),
        hh['max_dmg'].to_s.ljust(12),
        hh['accurasy'].to_s.ljust(12),
        hh['armor'].to_s.ljust(12),
        hh['skill_points']
      ].join
    end
    MainRenderer.new(:messages_full_screen, entity: @messages).display
    @messages.clear_log
    choose = gets.to_i
    if choose > 0 && choose <= heroes.length
      heroes[choose-1][0]
    else
      @messages.main = 'You mixed up the numbers, you stupid drunk -5 HP -5 MP -10 accuracy'
      MainRenderer.new(:messages_full_screen, entity: @messages).display
      gets
      'drunk'
    end
  end

  def monolith_bonuses
    pzdc_monolith = YAML.safe_load_file("saves/pzdc_monolith.yml")
    @hero.hp_max += pzdc_monolith['hp']
    @hero.hp += pzdc_monolith['hp']
    @hero.mp_max += pzdc_monolith['mp']
    @hero.mp += pzdc_monolith['mp']
    @hero.accuracy_base += pzdc_monolith['accuracy']
    while pzdc_monolith['damage'] > 0
      @hero.min_dmg_base < @hero.max_dmg_base && rand(0..1) == 0 ? @hero.min_dmg_base += 1 : @hero.max_dmg_base += 1
      pzdc_monolith['damage'] -= 1
    end
    @hero.stat_points += pzdc_monolith['stat_points']
    @hero.skill_points += pzdc_monolith['skill_points']
    @hero.armor_base += pzdc_monolith['armor']
    @hero.regen_hp_base += pzdc_monolith['regen_hp']
    @hero.regen_mp_base += pzdc_monolith['regen_mp']
  end

  def statistics_bonuses
    statistics = StatisticsTotal.new.data
    bandits_data, undeads_data, swamp_data = statistics['bandits'], statistics['undeads'], statistics['swamp']
    bandits_data.each do |enemy, count|
      if enemy == 'rabble' && count >= 50
        @hero.weapon = Weapon.new('stick')
      elsif enemy == 'rabid_dog' && count >= 50
        @hero.hp_max += 2
        @hero.hp += 2
      elsif enemy == 'poacher' && count >= 50
        @hero.accuracy_base += 1
      elsif enemy == 'thug' && count >= 50
        @hero.hp_max += 5
        @hero.hp += 5
      elsif enemy == 'deserter' && count >= 50
        @hero.stat_points += 1
      elsif enemy == 'bandit_leader' && count >= 5
        @hero.skill_points += 1
      end
    end
    undeads_data.each do |enemy, count|
      if enemy == 'zombie' && count >= 50
        @hero.arms_armor = ArmsArmor.new('worn_gloves')
      elsif enemy == 'skeleton' && count >= 50
        @hero.mp_max += 3
        @hero.mp += 3
      elsif enemy == 'ghost' && count >= 50
        @hero.accuracy_base += 1
      elsif enemy == 'fat_ghoul' && count >= 50
        @hero.hp_max += 7
        @hero.hp += 7
      elsif enemy == 'skeleton_soldier' && count >= 50
        @hero.block_chance_base += 3
      elsif enemy == 'zombie_knight' && count >= 5
        @hero.regen_mp_base += 1
      end
    end
    swamp_data.each do |enemy, count|
      if enemy == 'leech' && count >= 50
        @hero.mp_max += 3
        @hero.mp += 3
      elsif enemy == 'goblin' && count >= 50
        @hero.shield = Shield.new('holey_wicker_buckler')
      elsif enemy == 'sworm' && count >= 50
        @hero.hp_max += 3
        @hero.hp += 3
      elsif enemy == 'spider' && count >= 50
        @hero.accuracy_base += 1
      elsif enemy == 'orc' && count >= 50
        @hero.max_dmg_base += 1
      elsif enemy == 'ancient_snail' && count >= 5
        @hero.armor_base += 1
      end
    end
  end

  def shop_bonuses
    Warehouse.new.take_ammunition_by(@hero)
  end

  def active_skill
    @messages.main = 'Select an active skill'
    select_skill('active_skill')
  end

  def passive_skill
    @messages.main = 'Select a passive skill'
    select_skill('passive_skill')
  end

  def camp_skill
    @messages.main = 'Select a non-combat skill'
    select_skill('camp_skill')
  end

  def cheating
    if @hero.name == 'BAMBUGA'
      @hero.weapon = Weapon.new('bambuga')
      @hero.name = 'Cheater'
    end
  end

  private

  def select_skill(skill_type)
    @messages.log = SkillsShow.new(skill_type).show_in_hero_creator(@hero)
    MainRenderer.new(:messages_full_screen, entity: @messages).display
    choiсe = gets.strip.upcase
    indexes = SkillsShow.indexes_of_type(skill_type)
    until indexes.include?(choiсe)
      @messages.main = 'Invalid character entered. Try again'
      MainRenderer.new(:messages_full_screen, entity: @messages).display
      choiсe = gets.strip.upcase
    end
    skill_code = SkillsShow.skill_code_by_index(skill_type, choiсe.to_i - 1)
    @hero.send "#{skill_type}=", SkillsCreator.create(skill_code, @hero)
  end
end
















#
