class HeroCreator

  def initialize(dungeon_name)
    @messages = MainMessage.new

    @hero = Hero.new(name(), background(), dungeon_name)
  end

  def create_new_hero
    camp_bonuses
    active_skill
    passive_skill
    camp_skill
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
    @messages.log = [
      "                       Background:      Push:    Bonus:         ",
      "                       Watchman         (1)      15 hp          ",
      "                       Thief            (2)      5 accuracy     ",
      "                       Worker           (3)      15 mp          ",
      "                       Student          (4)      1 skill point  "
    ]
    MainRenderer.new(:messages_screen, entity: @messages).display
    @messages.clear_log
    choose_story_pl = gets.strip.upcase
    case choose_story_pl
    when '1'; 'watchman'
    when '2'; 'thief'
    when '3'; 'worker'
    when '4'; 'student'
    else
      @messages.main = 'You mixed up the letters, you stupid drunk -5 lives -5 stamina -10 accuracy'
      MainRenderer.new(:messages_screen, entity: @messages).display
      gets
      'drunk'
    end
  end

  def camp_bonuses # ?? потом разбить на отдельные контроллеры/сервисы
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

  def active_skill
    @messages.main = 'Select an active skill'
    @messages.log = [
      '   Skill:                  Push:           Description:',
      '   Strong Strike           (1)             Hit much harder',
      '   Precision Strike        (2)             Hit much more accurately and a little harder'
    ]
    MainRenderer.new(:messages_screen, entity: @messages).display
    special_choiсe = gets.strip.upcase
    while special_choiсe != '1' && special_choiсe != '2'
      @messages.main = 'Invalid character entered. Try again'
      MainRenderer.new(:messages_screen, entity: @messages).display
      special_choiсe = gets.strip.upcase
    end
    skills = {'1' => 'strong_strike', '2' => 'precise_strike'}
    @hero.active_skill = SkillsCreator.create(skills[special_choiсe], @hero)
  end

  def passive_skill
    @messages.main = 'Select a passive skill'
    @messages.log = [
      '   Skill:                  Push:           Description:',
      "   Dazed                   (1)             If the damage is more than a portion of the enemy's HP, he loses 10-90(%) accuracy",
      '   Concentration           (2)             If mp is more than 100, then random additional damage is inflicted',
      '   Shield Master           (3)             Shield block chance increased'
    ]
    MainRenderer.new(:messages_screen, entity: @messages).display
    passive_choiсe = gets.strip.upcase
    while passive_choiсe != '1' && passive_choiсe != '2' && passive_choiсe != '3'
      @messages.main = 'Invalid character entered. Try again'
      MainRenderer.new(:messages_screen, entity: @messages).display
      passive_choiсe = gets.strip.upcase
    end
    skills = {'1' => 'dazed', '2' => 'concentration', '3' => 'shield_master'}
    @hero.passive_skill = SkillsCreator.create(skills[passive_choiсe], @hero)
  end

  def camp_skill
    @messages.main = 'Select a non-combat skill'
    @messages.log = [
      '   Skill:                  Push:           Description:',
      '   First Aid               (1)             Restores HP, the more HP lost, the greater the effect',
      '   Treasure Hunter         (2)             Chance to find unique loot increased'
    ]
    MainRenderer.new(:messages_screen, entity: @messages).display
    noncombat_choiсe = gets.strip.upcase
    while noncombat_choiсe != '1' && noncombat_choiсe != '2'
      @messages.main = 'Invalid character entered. Try again'
      MainRenderer.new(:messages_screen, entity: @messages).display
      noncombat_choiсe = gets.strip.upcase
    end
    skills = {'1' => 'first_aid', '2' => 'treasure_hunter'}
    @hero.camp_skill = SkillsCreator.create(skills[noncombat_choiсe], @hero)
  end
end
















#
