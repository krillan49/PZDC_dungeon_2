class Main
  def initialize
    @hero = nil
    @enemy = nil
    @leveling = 0
    @run = false
  end

  def start_game
    load_or_create_hero()
    while true
      before_battle()
      battle()
      after_battle()
    end
  end

  def load_or_create_hero
    change_screen()
    while !@hero
      print 'Ведите 1 чтобы загрузить персонажа, введите 2 чтобы создать нового персонажа '
      new_load = gets.strip
      if new_load == '2'
        @hero = HeroCreator.new.create_new_hero # Создание нового персонажа
        autosave()
      else
        load_hero = LoadHero.new
        load_hero.load
        @hero = load_hero.hero
        @leveling = load_hero.leveling
      end
    end
  end

  def before_battle
    HeroUpdator.new(@hero).spend_stat_points # распределение очков характеристик
    HeroUpdator.new(@hero).spend_skill_points # распределение очков навыков  (тут вызывается старое меню, потом доделать)

    # Характеристики персонажа
    MainRenderer.new(:hero_header, @hero).display
    MainRenderer.new(:character_stats, @hero).display
    MainRenderer.new(:character_skills, @hero).display

    confirm_and_change_screen()
    autosave()

    HeroUseSkill.camp_skill(@hero) # Навык Первая помощь
    HeroActions.rest(@hero) # пассивное восстановления жизней и маны между боями

    confirm_and_change_screen()
  end

  def battle
    puts "++++++++++++++++++++++++++++++++++++++ Бой #{@leveling + 1} +++++++++++++++++++++++++++++++++++++++++++++++++"

    @enemy = EnemyCreator.new(@leveling).create_new_enemy # Назначение противника

    MainRenderer.new(:enemy_header, @enemy).display  # Характеристики противника
    MainRenderer.new(:character_stats, @enemy).display

    # Ход боя
    @run = false
    lap = 1 # номер хода
    while @enemy.hp > 0 && @run == false
      confirm_and_change_screen()
      puts "====================================== ХОД #{lap} ============================================"

      round = AttacksRound.new(@hero, @enemy)
      round.action
      @run = round.hero_run?

      lap += 1 # номер хода
    end

    confirm_and_change_screen()
  end

  def after_battle
    puts '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

    # Сбор лута
    if @run == false
      EnemyLoot.new(@hero, @enemy).looting
      FieldLoot.new(@hero).looting
      SecretLoot.new(@hero).looting
    end

    HeroActions.add_exp_and_hero_level_up(@hero, @enemy.exp_gived) if !@run # Получение опыта и очков

    confirm_and_change_screen()

    puts '-------------------------------------------------------------------------------------------------'
    @leveling += 1
  end

  private

  def autosave
    print "\nautosave..."
    SaveHero.new(@hero, @leveling).save
    puts "done\n"
  end

  def confirm_and_change_screen
    print 'Чтобы продолжить нажмите Enter'
    gets
    puts "\e[H\e[2J"
  end

  def change_screen
    puts "\e[H\e[2J"
  end
end

















#
