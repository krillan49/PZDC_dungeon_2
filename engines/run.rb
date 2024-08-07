class Run
  def initialize(hero, leveling)
    @hero = hero
    @leveling = leveling

    @enemy = nil
    @run = false
    @messages = MainMessage.new
  end

  def start
    while true
      hero_update()
      save_and_exit()
      camp_actions()
      event_or_enemy_choose()
      battle()
      after_battle()
    end
  end

  def hero_update
    HeroUpdator.new(@hero).spend_stat_points # распределение очков характеристик
    HeroUpdator.new(@hero).spend_skill_points # распределение очков навыков  (тут вызывается старое меню, потом доделать)
  end

  def save_and_exit
    @messages.main = 'Save this run and exit game? [y/N]'
    MainRenderer.new(:hero_update_screen, @hero, @hero, entity: @messages).display
    choose = gets.strip.upcase
    if choose == 'Y'
      # сохранение персонажа
      SaveHeroInRun.new(@hero, @leveling).save
      change_screen()
      exit
    end
  end

  def camp_actions
    HeroUseSkill.camp_skill(@hero, @messages) # Навык Первая помощь
    HeroActions.rest(@hero, @messages) # пассивное восстановления жизней и маны между боями
    @messages.main = 'To continue press Enter'
    MainRenderer.new(:messages_screen, entity: @messages, arts: [{ camp_fire: :rest }]).display
    @messages.clear_log
    confirm_and_change_screen()
  end

  def event_or_enemy_choose
    # Выбор противника
    enemy1 = EnemyCreator.new(@leveling).create_new_enemy
    enemy2 = EnemyCreator.new(@leveling).create_new_enemy
    enemy3 = EnemyCreator.new(@leveling).create_new_enemy
    n = 50
    @messages.main = 'Which way will you go?'
    until n >= 0 && n <= 2
      MainRenderer.new(
        :event_choose_screen, enemy1, enemy2, enemy3,
        entity: @messages, arts: [{ mini: enemy1 }, { mini: enemy2 }, { mini: enemy3 }]
      ).display
      n = gets.to_i - 1
      if n >= 0 && n <= 2
        @enemy = [enemy1, enemy2, enemy3][n]
      else
        @messages.main = 'There is no such way. Which way will you go?'
      end
    end
    # Характеристики противника
    @attacks_round_messages = AttacksRoundMessage.new
    @attacks_round_messages.main = 'To continue press Enter'
    @attacks_round_messages.actions = "++++++++++++ Battle #{@leveling + 1} ++++++++++++"
    MainRenderer.new(:enemy_start_screen, @enemy, entity: @attacks_round_messages, arts: [{ normal: @enemy }]).display
    confirm_and_change_screen()
  end

  def battle
    @run = false
    # lap = 1 # номер хода
    while @enemy.hp > 0 && @run == false
      round = AttacksRound.new(@hero, @enemy, @attacks_round_messages)
      round.action
      @run = round.hero_run?
      # lap += 1
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

  def display_message_screen_with_confirm_and_change_screen
    @messages.main = 'To continue press Enter'
    MainRenderer.new(:messages_screen, entity: @messages).display
    @messages.clear_log
    confirm_and_change_screen()
  end

  def confirm_and_change_screen
    gets
    change_screen()
  end

  def change_screen
    puts "\e[H\e[2J"
  end
end

















#
