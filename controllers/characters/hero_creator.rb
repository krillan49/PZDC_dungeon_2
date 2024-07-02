class HeroCreator

  def initialize
    puts 'Создание персонажа'
    puts '========================'
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
      print 'Введите имя персонажа: '
      input_name = gets.strip
      if !@taken_names && File::exists?("saves/0_options.yml")
        @taken_names = YAML.safe_load_file("saves/0_options.yml")['names']
      end
      if @taken_names && @taken_names.include?(input_name)
        puts "Персонаж с именем #{input_name} уже существует, выберите другое имя"
      elsif !input_name.match?(/[a-zA-Zа-яА-Я]/)
        puts "Некорректное имя. Имя должно содержать как минимум одну букву"
      elsif input_name.length > 20
        puts "Некорректное имя. Имя должно быть не более 20 символов"
      else
        name = input_name
      end
    end
    name
  end

  def background
    print "\nВыберите предисторию:\n" \
    "Сторож(G) + 30 жизней, Дубинка\n" \
    "Карманник(T) + 5 точности, Ножик\n" \
    "Рабочий(W) + 30 выносливости, Ржавый топорик\n" \
    "Умник(S) + 5 очков навыков, без оружия\n"
    choose_story_pl = gets.strip.upcase
    case choose_story_pl
    when 'G'; 'watchman'
    when 'T'; 'thief'
    when 'W'; 'worker'
    when 'S'; 'student'
    else
      puts 'Перепутал буквы, ты тупой алкаш -5 жизней -5 выносливости -10 точность'
      'drunk'
    end
  end

  def active_skill
    puts 'Выберите стартовый активный навык '
    print 'Сильный удар(S) Точный удар(A) '
    special_choiсe = gets.strip.upcase
    while special_choiсe != 'S' && special_choiсe != 'A'
      print 'Введен неверный символ. Попробуйте еще раз. Сильный удар(S) Точный удар(A) '
      special_choiсe = gets.strip.upcase
    end
    skills = {'S' => 'strong_strike', 'A' => 'srecise_strike'}
    @hero.active_skill = SkillsCreator.create(skills[special_choiсe], @hero)
  end

  def passive_skill
    puts 'Выберите стартовый пассивный навык '
    print 'Ошеломление(D) Концентрация(C) Мастер щита(B) '
    passive_choiсe = gets.strip.upcase
    while passive_choiсe != 'D' && passive_choiсe != 'C' && passive_choiсe != 'B'
      print 'Неверный символ попробуйте еще раз. Ошеломление(D) Концентрация(C) Мастер щита(B) '
      passive_choiсe = gets.strip.upcase
    end
    skills = {'D' => 'dazed', 'C' => 'concentration', 'B' => 'shield_master'}
    @hero.passive_skill = SkillsCreator.create(skills[passive_choiсe], @hero)
  end

  def camp_skill
    puts 'Выберите стартовый небоевой навык '
    print 'Первая помощь(F) Кладоискатель(T) '
    noncombat_choiсe = gets.strip.upcase
    while noncombat_choiсe != 'F' && noncombat_choiсe != 'T'
      print 'Введен неверный символ попробуйте еще раз. Первая помощь(F) Кладоискатель(T) '
      noncombat_choiсe = gets.strip.upcase
    end
    skills = {'F' => 'first_aid', 'T' => 'treasure_hunter'}
    @hero.camp_skill = SkillsCreator.create(skills[noncombat_choiсe], @hero)
  end
end


# require_relative "hero"
# require_relative "skills"
# hero = HeroCreator.new.create_new_hero
# p hero
















#
