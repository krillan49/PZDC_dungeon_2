class Main
  def initialize
    @hero = nil
    @enemy = nil
    @leveling = 0
    @run = false

    @messages = MainMessage.new
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
      MainRenderer.new( :start_screen, arts: [ { poster_start: :poster_start } ] ).display
      new_load = gets.strip
      change_screen()
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
    confirm_and_change_screen()

    # Ход боя
    @run = false
    lap = 1 # номер хода
    while @enemy.hp > 0 && @run == false

      round = AttacksRound.new(@hero, @enemy)
      round.action
      @run = round.hero_run?

      lap += 1 # номер хода
    end

  end

  def after_battle
    # Сбор лута
    if @run == false
      EnemyLoot.new(@hero, @enemy).looting
      FieldLoot.new(@hero).looting
      SecretLoot.new(@hero).looting
    end

    # Получение опыта и очков
    HeroActions.add_exp_and_hero_level_up(@hero, @enemy.exp_gived, @messages) if !@run
    display_message_screen_with_confirm_and_change_screen()

    @leveling += 1
  end

  private

  def autosave
    print "\nautosave..."
    SaveHero.new(@hero, @leveling).save
    puts "done\n"
  end

  def display_message_screen_with_confirm_and_change_screen
    @messages.main = 'Чтобы продолжить нажмите Enter'
    MainRenderer.new(:messages_screen, entity: @messages).display
    gets
    puts "\e[H\e[2J"
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
