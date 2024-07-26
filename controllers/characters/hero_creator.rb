class HeroCreator

  def initialize
    @messages = MainMessage.new

    @hero = Hero.new(name(), background())
  end

  def create_new_hero
    active_skill
    passive_skill
    camp_skill
    @hero
  end

  private

  def name
    name = nil
    while !name
      @messages.main = 'Введите имя персонажа' if @messages.main == ''
      @messages.log << 'Имя персонажа должно содержать как минимум 1 букву и быть не более 20 символов'
      MainRenderer.new(:messages_screen, entity: @messages).display
      input_name = gets.strip
      if !@taken_names && File::exists?("saves/0_options.yml")
        @taken_names = YAML.safe_load_file("saves/0_options.yml")['names']
      end
      if @taken_names && @taken_names.include?(input_name)
        @messages.main = "Персонаж с именем #{input_name} уже существует, выберите другое имя"
      elsif !input_name.match?(/[a-zA-Zа-яА-Я]/)
        @messages.main = "#{input_name} некорректное имя. Имя должно содержать как минимум одну букву"
      elsif input_name.length > 20
        @messages.main = "#{input_name} некорректное имя. Имя должно быть не более 20 символов"
      else
        name = input_name
      end
    end
    name
  end

  def background
    @messages.main = 'Выберите предисторию'
    @messages.log = [
      "                       Предыстория:   Нажмите:   Бонус:             Экипировка:",
      "                       Сторож           (G)      30 жизней          Дубинка",
      "                       Карманник        (T)      5 точности         Ножик",
      "                       Рабочий          (W)      30 выносливости    Ржавый топорик",
      "                       Студент          (S)      5 очков навыков    без оружия"
    ]
    MainRenderer.new(:messages_screen, entity: @messages).display
    @messages.clear_log
    choose_story_pl = gets.strip.upcase
    case choose_story_pl
    when 'G'; 'watchman'
    when 'T'; 'thief'
    when 'W'; 'worker'
    when 'S'; 'student'
    else
      @messages.main = 'Перепутал буквы, ты тупой алкаш -5 жизней -5 выносливости -10 точность'
      MainRenderer.new(:messages_screen, entity: @messages).display
      gets
      'drunk'
    end
  end

  def active_skill
    @messages.main = 'Выберите стартовый активный навык'
    @messages.log = [
      '   Skill:                  Push:           Description:',
      '   Сильный удар            (S)             Бей намного сильнее',
      '   Точный удар             (A)             Бей намного точнее и немного сильнее'
    ]
    MainRenderer.new(:messages_screen, entity: @messages).display
    special_choiсe = gets.strip.upcase
    while special_choiсe != 'S' && special_choiсe != 'A'
      @messages.main = 'Введен неверный символ. Попробуйте еще раз'
      puts "\e[H\e[2J"
      MainRenderer.new(:messages_screen, entity: @messages).display
      special_choiсe = gets.strip.upcase
    end
    skills = {'S' => 'strong_strike', 'A' => 'srecise_strike'}
    @hero.active_skill = SkillsCreator.create(skills[special_choiсe], @hero)
  end

  def passive_skill
    @messages.main = 'Выберите стартовый пассивный навык'
    @messages.log = [
      '   Skill:                  Push:           Description:',
      '   Ошеломление             (D)             Если урон больше части hp врага то он теряет 10-90(%) точности',
      '   Концентрация            (C)             Если мана больше 100, то наносится случайный доп урон',
      '   Мастер щита             (B)             Шанс блока щита увеличен'
    ]
    MainRenderer.new(:messages_screen, entity: @messages).display
    passive_choiсe = gets.strip.upcase
    while passive_choiсe != 'D' && passive_choiсe != 'C' && passive_choiсe != 'B'
      @messages.main = 'Введен неверный символ. Попробуйте еще раз'
      puts "\e[H\e[2J"
      MainRenderer.new(:messages_screen, entity: @messages).display
      passive_choiсe = gets.strip.upcase
    end
    skills = {'D' => 'dazed', 'C' => 'concentration', 'B' => 'shield_master'}
    @hero.passive_skill = SkillsCreator.create(skills[passive_choiсe], @hero)
  end

  def camp_skill
    @messages.main = 'Выберите стартовый небоевой навык'
    @messages.log = [
      '   Skill:                  Push:           Description:',
      '   Первая помощь           (F)             Восстанавливает hp, чем больше hp потеряно, тем больше эффект',
      '   Кладоискатель           (T)             Шанс найти уникальный лут увеличен'
    ]
    MainRenderer.new(:messages_screen, entity: @messages).display
    noncombat_choiсe = gets.strip.upcase
    while noncombat_choiсe != 'F' && noncombat_choiсe != 'T'
      @messages.main = 'Введен неверный символ. Попробуйте еще раз'
      puts "\e[H\e[2J"
      MainRenderer.new(:messages_screen, entity: @messages).display
      noncombat_choiсe = gets.strip.upcase
    end
    skills = {'F' => 'first_aid', 'T' => 'treasure_hunter'}
    @hero.camp_skill = SkillsCreator.create(skills[noncombat_choiсe], @hero)
  end
end
















#
