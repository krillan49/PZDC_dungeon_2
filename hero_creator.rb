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
    print 'Введите имя персонажа: '
    name = gets.strip
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
    case special_choiсe
    when 'S'; @hero.active_skill = StrongStrike.new
    when 'A'; @hero.active_skill = PreciseStrike.new
    end
  end

  def passive_skill
    puts 'Выберите стартовый пассивный навык '
    print 'Ошеломление(D) Концентрация(C) Мастер щита(B) '
    passive_choiсe = gets.strip.upcase
    while passive_choiсe != 'D' && passive_choiсe != 'C' && passive_choiсe != 'B'
      print 'Неверный символ попробуйте еще раз. Ошеломление(D) Концентрация(C) Мастер щита(B) '
      passive_choiсe = gets.strip.upcase
    end
    case passive_choiсe
    when 'D'; @hero.passive_skill = Dazed.new
    when 'C'; @hero.passive_skill = Concentration.new(@hero)
    when 'B'; @hero.passive_skill = ShieldMaster.new
    end
  end

  def camp_skill
    puts 'Выберите стартовый небоевой навык '
    print 'Первая помощь(F) Кладоискатель(T) '
    noncombat_choiсe = gets.strip.upcase
    while noncombat_choiсe != 'F' && noncombat_choiсe != 'T'
      print 'Введен неверный символ попробуйте еще раз. Первая помощь(F) Кладоискатель(T) '
      noncombat_choiсe = gets.strip.upcase
    end
    case noncombat_choiсe
    when 'F'; @hero.camp_skill = FirstAid.new(@hero)
    when 'T'; @hero.camp_skill = TreasureHunter.new
    end
  end
end


# require_relative "hero"
# require_relative "skills"
#
# hero = HeroCreator.new.create_new_hero
# p hero
















#
