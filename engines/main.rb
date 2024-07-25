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
      autosave_and_camp_actions()
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
  end

  def autosave_and_camp_actions
    autosave()
    HeroUseSkill.camp_skill(@hero, @messages) # Навык Первая помощь
    HeroActions.rest(@hero, @messages) # пассивное восстановления жизней и маны между боями
    display_message_screen_with_confirm_and_change_screen()
  end

  def battle
    @enemy = EnemyCreator.new(@leveling).create_new_enemy # Назначение противника

    # Характеристики противника
    attacks_round_messages = AttacksRoundMessage.new
    attacks_round_messages.main = 'Чтобы продолжить нажмите Enter'
    attacks_round_messages.actions = "++++++++++++ Бой #{@leveling + 1} ++++++++++++"
    MainRenderer.new(:enemy_start_screen, @enemy, entity: attacks_round_messages, arts: [{ normal: @enemy }]).display
    gets
    puts "\e[H\e[2J"

    # Ход боя
    @run = false
    lap = 1 # номер хода
    while @enemy.hp > 0 && @run == false

      round = AttacksRound.new(@hero, @enemy, attacks_round_messages)
      round.action
      @run = round.hero_run?

      lap += 1 # номер хода
    end

  end

  def after_battle
    # Сбор лута
    loot = LootRound.new(@hero, @enemy, @run)
    loot.action

    # Получение опыта и очков
    HeroActions.add_exp_and_hero_level_up(@hero, @enemy.exp_gived, @messages) if !@run
    display_message_screen_with_confirm_and_change_screen()

    @leveling += 1
  end

  private

  def autosave
    SaveHero.new(@hero, @leveling).save
    @messages.log << "autosave... done"
  end

  def display_message_screen_with_confirm_and_change_screen
    @messages.main = 'Чтобы продолжить нажмите Enter'
    MainRenderer.new(:messages_screen, entity: @messages).display
    @messages.clear_log
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
