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
    cheating
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
      "                       Thief            (2)      3 accuracy     ",
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
    # 1. Monolith bonuses:
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

    # 2. Shop warehouse ammunition:
    Shop.new.take_ammunition_by(@hero)
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
    MainRenderer.new(:messages_screen, entity: @messages).display
    choiсe = gets.strip.upcase
    indexes = SkillsShow.indexes_of_type(skill_type)
    until indexes.include?(choiсe)
      @messages.main = 'Invalid character entered. Try again'
      MainRenderer.new(:messages_screen, entity: @messages).display
      choiсe = gets.strip.upcase
    end
    skill_code = SkillsShow.skill_code_by_index(skill_type, choiсe.to_i - 1)
    @hero.send "#{skill_type}=", SkillsCreator.create(skill_code, @hero)
  end
end
















#
